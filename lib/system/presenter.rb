# frozen_string_literal: true

require_relative 'io_handler'
require_relative 'bank_database'
require_relative 'cash_dispenser'
require_relative 'user'
require_relative 'questions'

# presenter.rb
class Presenter
  include Questions

  attr_accessor :database, :stream, :atm, :user

  def initialize(config = {})
    # TODO
    @database = BankDataBase.new(config)
    @atm      = CashDispenser.new(config)
    @stream   = InputOutputHandler.new
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
    @user = User.new(user_id, database.config)
  end

  def deposit
    amount   = ask_deposit_amount
    currency = ask_currency
    atm.deposit(amount, currency)
    user.deposit(amount, currency)
    menu
  end

  def withdraw
    amount   = ask_withdraw_amount
    currency = ask_currency
    stream.print_output(atm.withdraw(amount, currency))
    menu
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
end
