

# CashDispenser
class CashDispenser
  # CashDispenser class defined for
  # storing information about
  # banknotes avaliable in current
  # cash dispenser in different
  # currencies and provide interfaces
  # for user login/logout and interactions
  # with bank database and interfaces
  attr_accessor :banknotes

  def initialize(database = {})
    @banknotes = database.fetch(:banknotes)
  end
  # TODO
end