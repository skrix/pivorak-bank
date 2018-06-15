# frozen_string_literal: true

# output_handler.rb
class OutputHandler
  # TODO
  def initialize; end

  # TODO
  def start_msg
    'Please Enter Your Personal ID:'
  end

  def password_msg
    'Enter Your Password:'
  end

  def greet(user_name)
    "Hello, #{user_name}!"
  end

  def display_main_menu
    "Please Choose From the Following Options:\n\
     1. Display Balance\n\
     2. Deposit\n\
     2. Withdraw\n\
     4. Transfer\n\
     5. Log Out\n"
  end

  def current_balance_info(uah_amount, usd_amount)
    "Your Current Balance is #{uah_amount} UAH, #{usd_amount} USD"
  end

  def new_balance_info(uah_amount, usd_amount = nil)
    if usd_amount.nil?
      "Your New Balance is #{uah_amount} UAH"
    else
      "Your New Balance is #{uah_amount} UAH, #{usd_amount} USD"
    end
  end

  def display_currency_menu
    "Please select currency:\n\
     1. UAH\n\
     2. USD\n"
  end

  def deposit_question
    'Enter Amount You Wish to Deposit:'
  end

  def withdraw_question
    'Enter Amount You Wish to Withdraw:'
  end

  def transfer_question
    'Please enter receiver name:'
  end

  def amount_question
    'Please enter amount:'
  end

  def transfer_success
    'Transfer Completed!'
  end

  def goodbye(user_name)
    "#{user_name}, Thank You For Using Our ATM. Good-Bye!"
  end
end
