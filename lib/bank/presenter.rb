# frozen_string_literal: true

# presenter.rb
class Presenter
  # TODO
  def initialize(config = {})
    # TODO
    @database = BankDataBase.new(config)
    @atm      = CashDispenser.new(config)
    @input    = InputHandler.new
  end
  # TODO
end
