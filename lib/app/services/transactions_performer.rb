# frozen_string_literal: true

class TransactionsPerformer
  NAME     = 'name'
  PASSWORD = 'password'
  CURRENCY = 'currency'
  UAH      = 'uah'
  USD      = 'usd'
  BALANCE  = 'balance'
  USER_ID  = 'user_id'

  attr_accessor :database

  def initialize(database)
    @database = database
  end

  def check_user_id(user_id)
    database.users.fetch(user_id)
  end

  def check_user_name(user_name)
    database.users.keys.each do |id|
      return id if database.users[id].fetch(NAME) == user_name
    end
    nil
  end

  def check_password(user_id, password)
    database.users[user_id].fetch(PASSWORD).eql?(password)
  end

  def check_account(user_id, currency)
    database.accounts.keys.each do |account|
      correct_user     = database.accounts[account].fetch(USER_ID)  == user_id
      correct_currency = database.accounts[account].fetch(CURRENCY) == currency
      return account if correct_user && correct_currency
    end
    nil
  end

  def create_user(user_id)
    User.new(user_id, database.users[user_id])
  end

  def make_deposit(user_id, amount, currency)
    account_id = check_account(user_id, currency)
    return if account_id.nil?

    update_deposits(account_id, amount)
    update_account_add_funds(account_id, amount)
    upd_bills = { 1 => amount }
    update_cash(currency, upd_bills)
  end

  def make_withdraw(user_id, amount, currency)
    account_id = check_account(user_id, currency)
    return if account_id.nil?

    upd_bills = Paydesk.call(database.banknotes[currency], amount)
    return if upd_bills.nil?

    update_withdraws(account_id, amount)
    update_account_sub_funds(account_id, amount)
    update_cash(currency, upd_bills)
  end

  def make_transfer(target_id, source_id, amount)
    update_account_sub_funds(source_id, amount)
    update_account_add_funds(target_id, amount)
    update_transfers(target_id, source_id, amount)
  end

  def user_balance(user_id, balance = {})
    database.banknotes.keys.each do |currency|
      account = check_account(user_id, currency)
      next if account.nil?

      balance[currency] ||= 0
      balance[currency]  += database.accounts[account][BALANCE]
    end
    balance
  end

  def save(config)
    database.update(config)
  end

  private

  def new_deposit_id
    return 1 if database.deposits.keys[-1].nil?

    database.deposits.keys[-1] + 1
  end

  def new_withdraw_id
    return 1 if database.withdraws.keys[-1].nil?

    database.withdraws.keys[-1] + 1
  end

  def new_transfer_id
    return 1 if database.transfers.keys[-1].nil?

    database.transfers.keys[-1] + 1
  end

  def update_withdraws(account_id, amount)
    database.withdraws_update(Withdrawal.new(new_withdraw_id, account_id, amount).to_h)
  end

  def update_deposits(account_id, amount)
    database.deposits_update(Deposit.new(new_deposit_id, account_id, amount).to_h)
  end

  def update_transfers(target_id, source_id, amount)
    database.transfers_update(Transfer.new(new_transfer_id, target_id, source_id, amount).to_h)
  end

  def update_cash(currency, bills)
    database.banknotes_update(currency, bills)
  end

  def update_account_add_funds(account_id, amount)
    account = Account.new(account_id, database.accounts[account_id])
    account.add_funds(amount)
    database.accounts_update(account.to_h)
  end

  def update_account_sub_funds(account_id, amount)
    account = Account.new(account_id, database.accounts[account_id])
    account.sub_funds(amount)
    database.accounts_update(account.to_h)
  end
end
