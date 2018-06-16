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
  attr_accessor :amount, :account_id
  attr_accessor :withdrawal_id

  def initialize(withdrawal_id, options = {})
    super(options)
    @withdrawal_id = withdrawal_id
    @account_id    = options.fetch(:account_id)
    @amount        = options.fetch(:amount, 0)
  end

  def call
    # TODO
  end
end
