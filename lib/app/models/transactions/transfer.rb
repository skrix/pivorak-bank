# frozen_string_literal: true

# transfers.rb
# Transfer class defined as
# child class of Transactions
# for save information about
# money transfers between users
# and give interfaces for
# make transfers in different
# currencys from one user to another
class Transfer < Transaction
  AMOUNT         = 'amount'
  TARGET_ACCOUNT = 'target_account'
  SOURCE_ACCOUNT = 'source_account'

  def initialize(transfer_id, target_account, source_account, amount = 0)
    super(amount)

    @transfer_id    = transfer_id
    @source_account = source_account
    @target_account = target_account
  end

  attr_reader :source_account, :transfer_id,
              :target_account, :amount

  def to_h
    {
      transfer_id => {
        AMOUNT         => amount,
        SOURCE_ACCOUNT => source_account,
        TARGET_ACCOUNT => target_account
      }
    }
  end
end
