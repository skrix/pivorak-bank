# frozen_string_literal: true

# transaction.rb
# Transaction class defined as
# father class for different types
# of bank transactions like
# deposits, transfers, withdrawals
class Transaction
  attr_accessor :currency, :amount

  def initialize(options = {})
    @currency = options.fetch(:currency, :uah)
    @amount   = options.fetch(:amount, 0)
  end

  # TODO
end
