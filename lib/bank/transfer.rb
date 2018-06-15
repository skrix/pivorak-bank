# frozen_string_literal: true

require 'transaction'

# transfers.rb
# Transfer class defined as
# child class of Transactions
# for save information about
# money transfers between users
# and give interfaces for
# make transfers in different
# currencys from one user to another
class Transfer < Transaction
  attr_accessor :currency, :amount
  attr_accessor :source_account, :target_account
  attr_accessor :transfer_id

  def initialize(source_account, target_account)
    super
    @transfer_id    = auto_id
    @source_account = source_account
    @target_account = target_account
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
