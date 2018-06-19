# frozen_string_literal: true

require_relative 'transaction'

# withdrawal.rb
# Withdrawal class defined as
# child class of Transactions
# for save information about
# withdrawals of bank users
# and give interfaces for
# make withdrawals in different
# currencies
class Withdrawal < Transaction
  attr_accessor :account_id, :withdrawal_id

  def initialize(withdrawal_id, account_id, amount = 0)
    super(amount)
    @withdrawal_id = withdrawal_id
    @account_id    = account_id
  end

  def to_h
    Hash[ withdrawal_id => {
      'amount'     => amount,
      'account_id' => account_id
    }]
  end
end
