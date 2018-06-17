# frozen_string_literal: true

require_relative '../system/io_handler'

module Questions
  def ask_id
    stream.print_output('Please Enter Your Personal ID:')
    stream.read_input.to_i
  end

  def ask_password
    stream.print_output('Enter Your Password:')
    stream.read_input
  end

  def ask_deposit_amount
    stream.print_output('Enter Amount You Wish to Deposit:')
    stream.read_input.to_i
  end

  def ask_withdraw_amount
    stream.print_output('Enter Amount You Wish to Withdraw:')
    stream.read_input.to_i
  end

  def ask_transfer_receiver
    stream.print_output('Please enter receiver name:')
    stream.read_input
  end

  def ask_amount
    stream.print_output('Please enter amount:')
    stream.read_input.to_i
  end

  def ask_currency
    stream.print_output("Please select currency:\n
    1. UAH\n
    2. USD\n")
    choose = stream.read_input.to_i
    case choose
    when 1 then 'uah'
    when 2 then 'usd'
    end
  end
end
