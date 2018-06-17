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

  def initialize(transfer_id, options = {})
    super(options)
    @transfer_id    = transfer_id
    @source_account = options.fetch(:source_account)
    @target_account = options.fetch(:target_account)
    @amount         = options.fetch(:amount, 0)
  end

  def call
    # TODO
  end

  private

  def transfer(currency, amount, source_account, target_account)
    # TODO
  end
  # TODO
end
