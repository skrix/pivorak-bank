# frozen_string_literal: true

require 'data_model_behavior'

# currency.rb
# Currency class defined for
# saving information about
# currencies and currency rates
# and give interfaces for exchange
# money in one currency to another
class Currency
  include DataModelBehavior

  attr_accessor :currency_name, :currency_uah_rate

  def initialize(currency_name, currency_uah_rate)
    @currency_id       = auto_id
    @currency_name     = currency_name
    @currency_uah_rate = currency_uah_rate
  end

  def rates
    # TODO
  end

  def exchange(amount, from_currency, to_currency)
    # TODO
  end
  # TODO
end
