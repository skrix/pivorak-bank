# frozen_string_literal: true

require 'data_model_behavior'

# transaction.rb
# Transaction class defined as
# father class for different types
# of bank transactions like
# deposits, transfers, withdrawals
class Transaction
  include DataModelBehavior

  attr_accessor :currency, :amount

  def initialize(currency, amount)
    @currency = currency
    @amount   = amount
  end

  # TODO
end
