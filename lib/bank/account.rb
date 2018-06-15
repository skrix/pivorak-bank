# frozen_string_literal: true

# account.rb
# Account class defined for
# storing information about
# user's accounts with different
# currencies and amount of money
class Account
  attr_accessor :currency, :balance, :account_id, :user_id

  def initialize(currency, balance, user_id)
    @currency   = currency
    @balance    = balance
    @account_id = account_id
    @user_id    = user_id
  end
  # TODO
end
