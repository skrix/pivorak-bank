# frozen_string_literal: true

require_relative 'io_handler'
require_relative 'errors_handler'
require_relative '../modules/questions'
require_relative '../modules/errors_out'

# presenter.rb
class Presenter
  include Questions

  attr_accessor :service, :stream, :user, :error

  def initialize(service)
    @service = service
    @stream  = InputOutputHandler.new
    @error   = ErrorsOut.new
  end

  def call
    login
  end

  private

  def login
    id = ask_id.to_i
    if service.check_user_id(id)
      password = ask_password
      service.check_password(id, password) ? login_succeed(id) : login_error(error.wrong_password)
    else
      login_error(error.id_does_not_exist)
    end
  end

  def login_succeed(user_id)
    @user = service.create_user(user_id)
    stream.print_output("Hello, #{@user.user_name}!")
    menu
  end

  def login_error(message)
    stream.print_output(message)
    login
  end

  def deposit
    amount   = ask_deposit_amount
    currency = ask_currency
    service.make_deposit(user.user_id, amount, currency)
    new_balance_info(service.user_balance(user.user_id))
    menu
  end

  def withdraw
    amount   = ask_withdraw_amount
    currency = ask_currency
    service.make_withdraw(user.user_id, amount, currency)
    new_balance_info(service.user_balance(user.user_id))
    menu
  end

  def transfer
    amount      = ask_amount
    currency    = ask_currency
    target_user = service.check_receiver(ask_transfer_receiver)
    if target_user.nil?
      stream.print_output(error.transfer_error)
      return
    end
    service.make_transfer(service.user_account(target_user, currency),
                          service.user_account(user.user_id, currency), amount)
    new_balance_info(service.user_balance(user.user_id))
    menu
  end

  def show_balance
    current_balance_info(service.user_balance(user.user_id))
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

  def new_balance_info(balance = {})
    string = ['Your New Balance is',
              "#{balance.fetch('uah', 0)} UAH,",
              "#{balance.fetch('usd', 0)} USD"].join(' ')
    stream.print_output(string)
  end

  def current_balance_info(balance = {})
    string = ['Your Current Balance is',
              "#{balance.fetch('uah', 0)} UAH,",
              "#{balance.fetch('usd', 0)} USD"].join(' ')
    stream.print_output(string)
  end
end
