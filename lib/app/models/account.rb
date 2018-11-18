# frozen_string_literal: true

# account.rb
# Account class defined for
# storing information about
# user's accounts with different
# currencies and amount of money
class Account
  CURRENCY = 'currency'
  UAH      = 'uah'
  USD      = 'usd'
  BALANCE  = 'balance'
  USER_ID  = 'user_id'

  def initialize(account_id, options = {})
    @account_id = account_id
    @currency   = options.fetch(CURRENCY, UAH)
    @balance    = options.fetch(BALANCE, 0)
    @user_id    = options.fetch(USER_ID)
  end

  attr_reader :currency, :balance, :account_id, :user_id

  def sub_funds(amount)
    @balance -= amount
  end

  def add_funds(amount)
    @balance += amount
  end

  def to_h
    {
      account_id => {
        CURRENCY => currency,
        BALANCE  => balance,
        USER_ID  => user_id
      }
    }
  end
end
