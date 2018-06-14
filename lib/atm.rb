# Upload configuration file
require 'yaml'

config = YAML.load_file(ARGV.first || 'config.yml')

# Transactions
class Transaction
  # Transaction class defined as
  # father class for different types
  # of bank transactions like
  # deposits, transfers, withdrawals
  attr_accessor :currency, :amount

  def initialize(currency, amount)
    @currency = currency
    @amount   = amount
  end
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
  attr_accessor :currency, :amount, :source_account, :target_account

  def initialize(source_account, target_account)
    super
    @source_account = source_account
    @target_account = target_account
  end

  def transfer(currency, amount, source_account, target_account)

  end
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

  def initialize(account_id)
    super
    @account_id = account_id
  end

  def deposit(currency, amount, account_id)

  end
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

  def initialize(account_id)
    super
    @account_id = account_id
  end

  def withdraw(currency, amount, account_id)
    puts 'Enter Amount You Wish to Withdraw:'
    amount = gets.chomp.to_i
    check_withdraw amount, id

    old = @data['accounts'][id]['balance']
    @data['accounts'][id]['balance'] = old - amount
    x = @data['accounts'][id]['balance']

    puts "Your New Balance is \u20B4 #{x}"
  end

  # def check_withdraw(amount, id)
  #   if amount > @data['accounts'][id]['balance']
  #     puts 'ERROR: INSUFFICIENT FUNDS!! PLEASE ENTER A DIFFERENT AMOUNT:'
  #     amount = gets.chomp.to_i
  #     check_withdraw amount, id
  #   end

  #   if amount > total
  #     puts "ERROR: THE MAXIMUM AMOUNT AVAILABLE IN THIS ATM IS \u20B4 #{total}. PLEASE ENTER A DIFFERENT AMOUNT:"
  #     amount = gets.chomp.to_i
  #     check_withdraw amount, id
  #   end

  #   if amount <= total
  #     unless possible amount
  #       puts 'ERROR: THE AMOUNT YOU REQUESTED CANNOT BE COMPOSED FROM BILLS \
  #       AVAILABLE IN THIS ATM. PLEASE ENTER A DIFFERENT AMOUNT:'
  #       amount = gets.chomp.to_i
  #       check_withdraw amount, id
  #     end
  #   end
  # end

  # def total
  #   total = 0
  #   for key in @data['banknotes'].keys
  #     total += @data['banknotes'][key] * key
  #   end
  #   total
  # end

  # def possible(summ)
  #   list_keys = @data['banknotes'].keys.sort.reverse
  #   rest = summ
  #   for x in list_keys
  #     if @data['banknotes'][x] > 0
  #       i = @data['banknotes'][x]
  #       while rest >= x && i >= 0
  #         rest -= x
  #         i -= 1
  #       end
  #     else
  #       next
  #     end
  #   end
  #   if rest > 0
  #     return false
  #   else
  #     return true
  #   end
  # end

end

# Currencies
class Currency
  # Currency class defined for
  # saving information about
  # currencies and currency rates
  # and give interfaces for exchange
  # money in one currency to another
  attr_accessor :currency, :rate

  def initialize(currency, rate)
    @currency = currency
    @rate     = rate
  end

  def rates

  end

  def exchange(amount, from_currency, to_currency)

  end
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
  attr_accessor :banknotes, :users, :accounts
  attr_accessor :deposits, :witdraws, :transfers

  def initialize(database = {})
    @banknotes = database.fetch(:banknotes)
    @users     = database.fetch(:users)
    @accounts  = database.fetch(:accounts)
    @deposits  = database.fetch(:deposits, nil)
    @witdraws  = database.fetch(:witdraws, nil)
    @transfers = database.fetch(:transfers, nil)
  end

  def login
    puts 'Please Enter Your Personal ID:'
    id = gets.chomp.to_i

    if !@data['accounts'].key?(id)
      puts "ERROR: ACCOUNT NUMBER DOESN'T EXIST"
      return
    else
      puts 'Enter Your Password:'
      password = gets.chomp
      if password.eql? @data['accounts'][id]['password']
        menu(id)
      else
        puts "ERROR: ACCOUNT NUMBER AND PASSWORD DON'T MATCH"
        login
      end
    end
  end

  def balance(id)
    x = @data['accounts'][id]['balance']
    puts("Your Current Balance is \u20B4 #{x}")
  end

  def logout(id)
    n = @data['accounts'][id]['name']
    puts "#{n}, Thank You For Using Our ATM. Good-Bye!"
    login
  end

  def menu(id)
    n = @data['accounts'][id]['name']
    puts "Hello, #{n}!\nPlease Choose From the Following Options:\n1. Display Balance\n2. Withdraw\n3. Log Out"

    get = gets.chomp.to_i
    case get
    when 1
      balance id
    when 2
      withdraw id
    when 3
      logout id
    end
  end
end

Atm = CashDispenser.new config
