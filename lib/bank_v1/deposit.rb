# frozen_string_literal: true

require_relative 'transaction'

# deposit.rb
# Deposit class defined as
# child class of Transactions
# for save information about
# deposits of bank users
# and give interfaces for
# make deposits in different
# currencys
class Deposit < Transaction
  attr_accessor :amount, :account_id
  attr_accessor :deposit_id

  def initialize(deposit_id = 1, options = {})
    super(options)
    @deposit_id = deposit_id
    @account_id = options.fetch(:account_id)
  end

  def call
    # TODO
  end

  private

  def deposit(currency, amount, account_id)
    # TODO
  end
  # TODO
end
