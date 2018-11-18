# frozen_string_literal: true

# deposit.rb
# Deposit class defined as
# child class of Transactions
# for save information about
# deposits of app users
# and give interfaces for
# make deposits in different
# currencys
class Deposit < Transaction
  AMOUNT     = 'amount'
  ACCOUNT_ID = 'account_id'

  def initialize(deposit_id, account_id, amount = 0)
    super(amount)

    @deposit_id = deposit_id
    @account_id = account_id
  end

  attr_accessor :amount, :account_id, :deposit_id

  def to_h
    {
      deposit_id => {
        AMOUNT     => amount,
        ACCOUNT_ID => account_id
      }
    }
  end
end
