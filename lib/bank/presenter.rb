# frozen_string_literal: true

require 'input_output_handler'
require 'bank_data_base'
require 'cash_dispenser'
require 'errors_out'
require 'user'

# presenter.rb
class Presenter
  attr_accessor :database, :stream, :atm, :user

  def initialize(config = {})
    # TODO
    @database = BankDataBase.new(config)
    @atm      = CashDispenser.new(config)
    @stream   = InputHandler.new
    @error    = ErrorsOut.new
  end

  def call
    login
  end

  private

  # TODO
  def login
    user_id = ask_id
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

  def ask_id
    stream.print_output('Please Enter Your Personal ID:')
    stream.read_input
  end

  def ask_password
    stream.print_output('Enter Your Password:')
    stream.read_input
  end

  def check_id_exist(user_id)
    database.users.key?(user_id)
  end

  def check_password(user_id, password)
    database.users[user_id].fetch(:password)
    database.users[user_id][:password] == password
  end

  def menu
    stream.print_output("\
    Please Choose From the Following Options:\n\
    1. Display Balance\n\
    2. Deposit\n\
    3. Withdraw\n\
    4. Transfer\n\
    5. Log Out\n")
    menu_choose_action
  end

  def menu_choose_action
    choose = stream.read_input
    case choose
    when 1  then  balance
    when 2  then  deposit
    when 3  then  withdraw
    when 4  then  transfer
    when 5  then  logout
    end
  end

  def balance
    
  end

  def deposit
    amount   = ask_deposit_amount
    currency = ask_currency
  end

  def withdraw
    amount   = ask_withdraw_amount
    currency = ask_currency
  end

  def transfer
    amount   = ask_amount
    currency = ask_currency
  end

  def logout
    stream.print_output("#{@user.user_name}, Thank You For Using Our ATM. Good-Bye!")
    delete_user
    login
  end

  def delete_user
    @user = nil
  end

  def create_user_by_id(user_id)
    @user = User.new(user_id, database.users[user_id][:name], database.users[user_id][:password])
  end

  def ask_deposit_amount
    stream.print_output('Enter Amount You Wish to Deposit:')
    stream.read_input
  end

  def ask_withdraw_amount
    stream.print_output('Enter Amount You Wish to Withdraw:')
    stream.read_input
  end

  def ask_transfer_receiver
    stream.print_output('Please enter receiver name:')
    stream.read_input
  end

  def ask_amount
    stream.print_output('Please enter amount:')
    stream.read_input
  end

  def ask_currency
    stream.print_output("Please select currency:\n\
                         1. UAH\n\
                         2. USD\n")
    choose = stream.read_input
    case choose
    when 1 then :uah
    when 2 then :usd
  end

  def new_balance_info(uah_amount, usd_amount = nil)
    if usd_amount.nil?
      "Your New Balance is #{uah_amount} UAH"
    else
      "Your New Balance is #{uah_amount} UAH, #{usd_amount} USD"
    end
  end

  def current_balance_info(uah_amount, usd_amount = 0)
    "Your Current Balance is #{uah_amount} UAH, #{usd_amount} USD"
  end
end
