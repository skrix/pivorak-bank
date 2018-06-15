# frozen_string_literal: true

require 'transaction'

# deposit.rb
# Deposit class defined as
# child class of Transactions
# for save information about
# deposits of bank users
# and give interfaces for
# make deposits in different
# currencys
class Deposit < Transaction
  attr_accessor :currency, :amount, :account_id
  attr_accessor :deposit_id

  def initialize(account_id)
    super
    @deposit_id = auto_id
    @account_id = account_id
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
