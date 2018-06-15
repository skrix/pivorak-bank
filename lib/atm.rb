# Upload configuration file
require 'yaml'

config = YAML.load_file(ARGV.first || 'config.yml')

# Module for methods
module DataModelBehavior
  def auto_id
    @id ||= 0
    @id += 1
  end
end

# Transactions
class Transaction
  # Transaction class defined as
  # father class for different types
  # of bank transactions like
  # deposits, transfers, withdrawals
  include DataModelBehavior

  attr_accessor :currency, :amount

  def initialize(currency, amount)
    @currency = currency
    @amount   = amount
  end

  # TODO
end

# Transfers
class Transfer < Transaction
  # Transfer class defined as
  # child class of Transactions
  # for save information about
  # money transfers between users
  # and give interfaces for
  # make transfers in different
  # currencys from one user to another
  attr_accessor :currency, :amount
  attr_accessor :source_account, :target_account
  attr_accessor :transfer_id

  def initialize(source_account, target_account)
    super
    @transfer_id    = auto_id
    @source_account = source_account
    @target_account = target_account
  end

  def call
    # TODO
  end

  private

  def transfer(currency, amount, source_account, target_account)
    # TODO
  end
  # TODO
end

# Deposits
class Deposit < Transaction
  # Deposit class defined as
  # child class of Transactions
  # for save information about
  # deposits of bank users
  # and give interfaces for
  # make deposits in different
  # currencys
  attr_accessor :currency, :amount, :account_id
  attr_accessor :deposit_id

  def initialize(account_id)
    super
    @deposit_id = auto_id
    @account_id = account_id
  end

  def call
    # TODO
  end

  private

  def deposit(currency, amount, account_id)
    # TODO
  end
  # TODO
end

# Withdrawals
class Withdrawal < Transaction
  # Withdrawal class defined as
  # child class of Transactions
  # for save information about
  # withdrawals of bank users
  # and give interfaces for
  # make withdrawals in different
  # currencys
  attr_accessor :currency, :amount, :account_id
  attr_accessor :withdrawal_id

  def initialize(account_id)
    super
    @withdrawal_id = auto_id
    @account_id    = account_id
  end

  def call
    # TODO
  end

  private

  def withdraw(amount, account_id, currency = :uah)
    # TODO
    compose(bills_hash, amount_formatter(amount))
  end
  # TODO

  def remainded_bills(bills_hash, used_bills_hash)
    # give information about bills after withdrawal
    used_bills_hash.keys.each do |key|
      bills_hash[key] -= used_bills_hash[key]
    end

    bills_hash
  end

  def compose(bills_hash, amount)
    # compose method for recursion
    # call greedy compose and resize hash
    arg_hash = bills_hash
    composed_bill = bill_greedy_compose(arg_hash, amount)

    while bills_hash_total(composed_bill) != amount
      arg_hash.delete(max_bill_in_hash(arg_hash))
      composed_bill = bill_greedy_compose(arg_hash, amount)
      return ERROR if arg_hash == {}
    end

    composed_bill
  end

  def bill_greedy_compose(bills_hash, amount)
    # simple greedy algorithm for compose bills
    used_bills_hash = {}

    bills_hash_keys_sort(bills_hash_clean(bills_hash)).reverse_each do |bill|
      next if amount < bill

      used_bills_hash[:"#{bill}"] = 0

      while amount >= bill && bills_hash[:"#{bill}"] > used_bills_hash[:"#{bill}"]
        amount -= bill
        used_bills_hash[:"#{bill}"] += 1
      end
    end

    used_bills_hash
  end

  def bills_hash_total(bills_hash)
    # count total of avaliable bills
    # return an integer num - total of hash values
    total_in_hash = 0

    bills_hash.each do |key, value|
      total_in_hash += (key.to_s.to_i * value.to_i)
    end

    total_in_hash
  end

  def bills_hash_clean(bills_hash)
    # cleaning hash with bills from non-existent and nil value key-value pairs
    # return hash without key-value where value nil or zero
    bills_hash.select { |_key, value| !value.nil? && value.positive? }
  end

  def bills_hash_keys_sort(bills_hash)
    # sorting hash keys in the order of growth
    # return an array with keys sorted from min to max
    bills_hash.keys.map { |e| e.to_s.to_i }.sort
  end

  def max_bill_in_hash(bills_hash)
    # return max bill key from hash
    :"#{bills_hash_keys_sort(bills_hash_clean(bills_hash))[-1]}"
  end

  def amount_formatter(amount)
    if amount.nil? || !amount.respond_to?(:to_i)
      false
    else
      amount.to_i
    end
  end
end

# Currencies
class Currency
  # Currency class defined for
  # saving information about
  # currencies and currency rates
  # and give interfaces for exchange
  # money in one currency to another
  include DataModelBehavior

  attr_accessor :currency_name, :currency_uah_rate

  def initialize(currency_name, currency_uah_rate)
    @currency_id       = auto_id
    @currency_name     = currency_name
    @currency_uah_rate = currency_uah_rate
  end

  def rates
    # TODO
  end

  def exchange(amount, from_currency, to_currency)
    # TODO
  end
  # TODO
end

# Accounts
class Account
  # Account class defined for
  # storing information about
  # user's accounts with different
  # currencies and amount of money
  attr_accessor :currency, :balance, :account_id, :user_id

  def initialize(currency, balance, user_id)
    @currency   = currency
    @balance    = balance
    @account_id = account_id
    @user_id    = user_id
  end
  # TODO
end

# Users
class User
  # User class defined for
  # storing information about
  # users
  attr_accessor :user_id, :user_name, :password

  def initialize(user_id, user_name, password)
    @user_id   = user_id
    @user_name = user_name
    @password  = password
  end
  # TODO
end

# BankDataBase
class BankDataBase
  # BankDataBase class defined for
  # storing all information about
  # users, accounts, transactions
  attr_accessor :users, :accounts
  attr_accessor :deposits, :witdraws, :transfers

  def initialize(database = {})
    @users     = database.fetch(:users)
    @accounts  = database.fetch(:accounts)
    @deposits  = database.fetch(:deposits, nil)
    @witdraws  = database.fetch(:witdraws, nil)
    @transfers = database.fetch(:transfers, nil)
  end
  # TODO
end

# CashDispenser
class CashDispenser
  # CashDispenser class defined for
  # storing information about
  # banknotes avaliable in current
  # cash dispenser in different
  # currencies and provide interfaces
  # for user login/logout and interactions
  # with bank database and interfaces
  attr_accessor :banknotes

  def initialize(database = {})
    @banknotes = database.fetch(:banknotes)
  end
  # TODO
end

# InputHandler
class InputHandler
  # TODO
  def initialize; end
  # TODO
end

# InputHandler
class OutputHandler
  # TODO
  def initialize; end

  # TODO
  def start_msg
    'Please Enter Your Personal ID:'
  end

  def password_msg
    'Enter Your Password:'
  end

  def greet(user_name)
    "Hello, #{user_name}!"
  end

  def display_main_menu
    "Please Choose From the Following Options:\n\
     1. Display Balance\n\
     2. Deposit\n\
     2. Withdraw\n\
     4. Transfer\n\
     5. Log Out\n"
  end

  def current_balance_info(uah_amount, usd_amount)
    "Your Current Balance is #{uah_amount} UAH, #{usd_amount} USD"
  end

  def new_balance_info(uah_amount, usd_amount = nil)
    if usd_amount.nil?
      "Your New Balance is #{uah_amount} UAH"
    else
      "Your New Balance is #{uah_amount} UAH, #{usd_amount} USD"
    end
  end

  def display_currency_menu
    "Please select currency:\n\
     1. UAH\n\
     2. USD\n"
  end

  def deposit_question
    'Enter Amount You Wish to Deposit:'
  end

  def withdraw_question
    'Enter Amount You Wish to Withdraw:'
  end

  def transfer_question
    'Please enter receiver name:'
  end

  def amount_question
    'Please enter amount:'
  end

  def transfer_success
    'Transfer Completed!'
  end

  def goodbye(user_name)
    "#{user_name}, Thank You For Using Our ATM. Good-Bye!"
  end
end

# Presenter
class Presenter
  # TODO
  def initialize(config = {})
    # TODO
    @database = BankDataBase.new(config)
    @atm      = CashDispenser.new(config)
    @input    = InputHandler.new
  end
  # TODO
end

runtime = Presenter.new(config)
