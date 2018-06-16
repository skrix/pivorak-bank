# frozen_string_literal: true

require 'input_output_handler'
require 'bank_data_base'
require 'cash_dispenser'
require 'errors_out'
require 'user'
require 'questions'

# presenter.rb
class Presenter
  include 'Questions'

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
  end

  def current_user_balance_hash(user_balance = {})
    database.accounts.keys.each do |account|
      current_id = database.accounts[account].fetch('user_id')
      if current_id.eql? @user.user_id
        currency = database.accounts[account]['currency']
        user_balance[currency] += database.accounts[account]['balance']
      end
    end
    user_balance
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
    login
  end

  def create_user_by_id(user_id)
    @user = User.new(user_id, database.users[user_id][:name], database.users[user_id][:password])
  end

  def new_balance_info(balance = {})
    if usd_amount.nil?
      "Your New Balance is #{balance[:uah]} UAH"
    else
      "Your New Balance is #{balance[:usd]} UAH, #{usd_amount} USD"
    end
  end

  def current_balance_info(balance = {})
    "Your Current Balance is #{balance[:uah]} UAH, #{balance[:usd]} USD"
  end
end
