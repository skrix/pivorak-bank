# encoding: utf-8

require 'yaml'

config = YAML.load_file ARGV.first || 'config.yml' 

class Atm
  protected
  :data
  def initialize args
    @data = args
    self.login
  end

  def login
    puts "Please Enter Your Account Number:"
    id = gets.chomp.to_i

    if !@data['accounts'].keys.include? id
      puts "ERROR: ACCOUNT NUMBER DOESN'T EXIST" 
      return
    else
      puts "Enter Your Password:"
      password = gets.chomp
      if password.eql? @data['accounts'][id]['password']
        self.menu(id)
      else
        puts "ERROR: ACCOUNT NUMBER AND PASSWORD DON'T MATCH"
        self.login
      end
    end
  end


  def balance id
    x = @data['accounts'][id]['balance']
    puts("Your Current Balance is \u20B4 #{x}")
  end

  def withdraw id
    puts "Enter Amount You Wish to Withdraw:"
    amount = gets.chomp.to_i
    self.check_withdraw amount,id

    old = @data['accounts'][id]['balance']
    @data['accounts'][id]['balance'] = old - amount
    x = @data['accounts'][id]['balance']

    puts "Your New Balance is \u20B4 #{x}"
    self.menu id 
  end


  def check_withdraw amount, id
    if amount > @data['accounts'][id]['balance']
      puts "ERROR: INSUFFICIENT FUNDS!! PLEASE ENTER A DIFFERENT AMOUNT:"
      amount = gets.chomp.to_i
      self.check_withdraw amount, id
    end

    if amount > self.total
      puts "ERROR: THE MAXIMUM AMOUNT AVAILABLE IN THIS ATM IS \u20B4 #{self.total}. PLEASE ENTER A DIFFERENT AMOUNT:"
      amount = gets.chomp.to_i
      self.check_withdraw amount, id
    end

    if amount <= self.total
      unless self.possible amount
        puts "ERROR: THE AMOUNT YOU REQUESTED CANNOT BE COMPOSED FROM BILLS AVAILABLE IN THIS ATM. PLEASE ENTER A DIFFERENT AMOUNT:"
        amount = gets.chomp.to_i
        self.check_withdraw amount, id
      end
    end
  end

  def logout id
    n = @data['accounts'][id]['name']
    puts "#{n}, Thank You For Using Our ATM. Good-Bye!"
    self.login
  end

  def total
    total = 0
    for key in @data['banknotes'].keys
      total += @data['banknotes'][key]*key
    end
    total
  end

  def possible summ
    list_keys = @data['banknotes'].keys.sort.reverse
    rest = summ
    for x in list_keys
      if @data['banknotes'][x] > 0
        i = @data['banknotes'][x]
        while rest >= x && i >= 0
          rest -= x
          i-=1
        end
      else
        next
      end
    end
    if rest > 0
      return false
    else
      return true
    end
  end


  def menu id
    n = @data['accounts'][id]['name']
    puts "Hello, #{n}!\nPlease Choose From the Following Options:\n1. Display Balance\n2. Withdraw\n3. Log Out"

    get = gets.chomp.to_i
    case get
    when 1
      self.balance id 
    when 2
      self.withdraw id 
    when 3
      self.logout id 
    end
  end
end

term = Atm.new config