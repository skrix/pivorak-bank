# frozen_string_literal: true

require_relative 'transaction'

# transfers.rb
# Transfer class defined as
# child class of Transactions
# for save information about
# money transfers between users
# and give interfaces for
# make transfers in different
# currencys from one user to another
class Transfer < Transaction
  attr_accessor :amount
  attr_accessor :source_account, :target_account
  attr_accessor :transfer_id

  def initialize(transfer_id, target_account, source_account, amount = 0)
    super(amount)
    @transfer_id    = transfer_id
    @source_account = source_account
    @target_account = target_account
  end

  # TODO
  def to_h
    Hash[ transfer_id => {
      'amount'         => amount,
      'source_account' => source_account,
      'target_account' => target_account
    }]
  end
end
