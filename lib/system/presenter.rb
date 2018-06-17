# frozen_string_literal: true

require_relative 'io_handler'
require_relative '../bank/bank_database'
require_relative '../bank/cash_dispenser'
require_relative '../bank/paydesk'
require_relative '../bank/user'
require_relative '../bank/deposit'
require_relative '../bank/transfer'
require_relative '../bank/withdrawal'
require_relative '../bank/account'
require_relative '../modules/questions'
require_relative '../modules/errors_out'

# presenter.rb
class Presenter
  include Questions

  attr_accessor :database, :stream, :atm, :user

  def initialize(config = {})
    @database = BankDatabase.new(config)
    @atm      = CashDispenser.new
    @stream   = InputOutputHandler.new
    @error    = ErrorsOut.new
  end

  def call
    login
  end

  private

  def login
    user_id = ask_id.to_i
    if check_id_exist(user_id)
      password = ask_password
      check_password(user_id, password) ? login_succeed(user_id) : login_error(error.wrong_password)
    else
      login_error(error.id_does_not_exist)
    end
  end

  def login_succeed(user_id)
    create_user_by_id(user_id)
    stream.print_output("Hello, #{@user.user_name}!")
    menu
  end

  def login_error(message)
    stream.print_output(message)
    login
  end

  def check_id_exist(user_id)
    database.users.fetch(user_id)
  end

  def check_password(user_id, password)
    database.users[user_id].fetch('password')
    database.users[user_id]['password'] == password
  end

  def create_user_by_id(user_id)
    @user = User.new(user_id, database.users[user_id])
  end

  def deposit
    amount   = ask_deposit_amount
    currency = ask_currency
    make_deposit(user.user_id, amount, currency)
    menu
  end

  def make_deposit(user_id, amount, currency)
    database.accounts.keys.each do |account_id|
      user_owned = database.accounts[account_id]['user_id'].eql? user_id
      proper_currency = database.accounts[account_id]['currency'].eql? currency

      if user_owned && proper_currency
        database.deposits_update(Deposit.new(new_deposit_id, account_id, amount).to_h)
        upd_info = Account.new(account_id, database.accounts[account_id])
        upd_info.add_funds(amount)
        database.accounts_update(upd_info.to_h)
        upd_bills = Hash[currency => { 1 => amount }]
        database.banknotes_update(upd_bills)
      end
    end
    balance_after_transaction
  end

  def new_deposit_id
    if database.deposits.keys[-1].nil?
      1
    else
      database.deposits.keys[-1] + 1
    end
  end

  def withdraw
    amount   = ask_withdraw_amount
    currency = ask_currency
    make_withdraw(user.user_id, amount, currency)
    menu
  end

  def make_withdraw(user_id, amount, currency)
    database.accounts.keys.each do |account_id|
      user_owned = database.accounts[account_id]['user_id'].eql? user_id
      proper_currency = database.accounts[account_id]['currency'].eql? currency

      if user_owned && proper_currency
        database.withdraws_update(Withdrawal.new(new_withdraw_id, account_id, amount).to_h)
        upd_info = Account.new(account_id, database.accounts[account_id])
        upd_info.sub_funds(amount)
        database.accounts_update(upd_info.to_h)
        upd_bills = Paydesk.new(database.banknotes[currency], amount).call
        if upd_bills.nil?
          error.composing_error
          withdraw
        end
        database.banknotes_update(upd_bills)
      end
    end
    balance_after_transaction
  end

  def new_withdraw_id
    if database.withdraws.keys[-1].nil?
      1
    else
      database.withdraws.keys[-1] + 1
    end
  end

  def transfer
    # amount   = ask_amount
    # currency = ask_currency
    menu
  end

  def logout
    stream.print_output("#{@user.user_name}, Thank You For Using Our ATM. Good-Bye!")
    login
  end

  def menu
    stream.print_output("Please Choose From the Following Options:\n\
    1. Display Balance\n\
    2. Deposit\n\
    3. Withdraw\n\
    4. Transfer\n\
    5. Log Out\n")
    menu_choose_action
  end

  def menu_choose_action
    choose = stream.read_input
    case choose.to_i
    when 1  then  show_balance
    when 2  then  deposit
    when 3  then  withdraw
    when 4  then  transfer
    when 5  then  logout
    end
  end

  def show_balance
    user_balance = current_user_balance_hash
    current_balance_info(user_balance)
    menu
  end

  def balance_after_transaction
    user_balance = current_user_balance_hash
    new_balance_info(user_balance)
    menu
  end

  def current_user_balance_hash(user_balance = {})
    database.accounts.keys.each do |account|
      current_id = database.accounts[account].fetch('user_id')

      if current_id.eql? user.user_id
        currency = database.accounts[account]['currency']
        user_balance[currency] ||= 0
        user_balance[currency] += database.accounts[account]['balance']
      end
    end
    user_balance
  end

  def new_balance_info(balance = {})
    stream.print_output("Your New Balance is #{balance['uah']} UAH, #{balance['usd']} USD")
  end

  def current_balance_info(balance = {})
    stream.print_output("Your Current Balance is #{balance['uah']} UAH, #{balance['usd']} USD")
  end
end
