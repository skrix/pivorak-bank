# Upload configuration file
require 'yaml'

config = YAML.load_file(ARGV.first || 'config.yml')

module Transactions
  class Transfers
    attr_accessor :currency, :amount, :source_account, :target_account

    def initialize(currency, amount, source_account, target_account)
      @currency = currency
      @amount = amount
      @source_account = source_account
      @target_account = target_account
    end

    def transfer(currency, amount, source_account, target_account)
      
    end
  end

  class Deposits
    attr_accessor :currency, :amount, :account_id

    def initialize(currency, amount, account_id)
      @currency = currency
      @amount = amount
      @account_id = account_id
    end

    def deposit(currency, amount, account_id)
      
    end
  end

  class Withdrawals
    attr_accessor :currency, :amount, :account_id

    def initialize(currency, amount, account_id)
      @currency = currency
      @amount = amount
      @account_id = account_id
    end

    def withdraw(currency, amount, account_id)
      
    end


  # def withdraw(id)
  #   puts 'Enter Amount You Wish to Withdraw:'
  #   amount = gets.chomp.to_i
  #   check_withdraw amount, id

  #   old = @data['accounts'][id]['balance']
  #   @data['accounts'][id]['balance'] = old - amount
  #   x = @data['accounts'][id]['balance']

  #   puts "Your New Balance is \u20B4 #{x}"
  #   menu id
  # end

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
end

class Currencies
  attr_accessor :currency, :rate

  def initialize(currency, rate)
    @currency = currency
    @rate = rate
  end
  
  def rates
    
  end

  def exchange(amount, from_currency, to_currency)
    
  end
end

class Accounts
  attr_accessor :currency, :balance, :account_id

  def initialize(currency, balance, account_id)
    @currency = currency
    @balance = balance
    @account_id = account_id
  end
end

class Users
  attr_accessor :account_id, :user_name, :password

  def initialize(account_id, user_name, password)
    @account_id = account_id
    @user_name = user_name
    @password = password
  end
end

class CashDispenser
  attr_accessor :banknotes

  def initialize(banknotes)
    @banknotes = banknotes
  end

  def login
    puts 'Please Enter Your Account Number:'
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
