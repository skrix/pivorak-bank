# frozen_string_literal: true

# account.rb
# Account class defined for
# storing information about
# user's accounts with different
# currencies and amount of money
class Account
  attr_accessor :currency, :balance, :account_id, :user_id

  def initialize(account_id, options = {})
    @account_id = account_id
    @currency   = options.fetch(:currency, :uah)
    @balance    = options.fetch(:balance, 0)
    @user_id    = options.fetch(:user_id)
  end

  def sub_funds(amount)
    @balance -= amount
  end

  def add_funds(amount)
    @balance += amount
  end

  def to_h
    Hash[ account_id => {
      'currency' => currency,
      'balance'  => balance,
      'user_id'  => user_id
    }]
  end
end
