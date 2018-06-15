# frozen_string_literal: true

require 'input_output_handler'
require 'bank_data_base'
require 'cash_dispenser'
require 'errors_out'

# presenter.rb
class Presenter
  attr_accessor :database, :stream, :atm

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
    user_name = database.users[user_id][:name]
    stream.print_output("Hello, #{user_name}!")
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
    database.users[user_id][:password] == password if database.users[user_id].fetch(:password)
  end
end
