# frozen_string_literal: true

# withdrawal.rb
# Withdrawal class defined as
# child class of Transactions
# for save information about
# withdrawals of app users
# and give interfaces for
# make withdrawals in different
# currencies
class Withdrawal < Transaction
  AMOUNT     = 'amount'
  ACCOUNT_ID = 'account_id'

  def initialize(withdrawal_id, account_id, amount = 0)
    super(amount)

    @withdrawal_id = withdrawal_id
    @account_id    = account_id
  end

  attr_reader :account_id, :withdrawal_id

  def to_h
    {
      withdrawal_id => {
        AMOUNT     => amount,
        ACCOUNT_ID => account_id
      }
    }
  end
end
