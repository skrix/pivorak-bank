# frozen_string_literal: true

# transaction.rb
# Transaction class defined as
# father class for different types
# of bank transactions like
# deposits, transfers, withdrawals
class Transaction
  attr_accessor :amount

  def initialize(amount = 0)
    @amount = amount
  end
end
