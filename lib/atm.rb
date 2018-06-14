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

  def withdraw(currency, amount, account_id)
    # TODO
  end
  # TODO
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
  def initialize(args)
    # TODO
  end
  # TODO
end

# Presenter
class Presenter
  # TODO
  def initialize(args)
    # TODO
  end
  # TODO
end
