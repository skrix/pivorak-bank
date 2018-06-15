# frozen_string_literal: true

# bank_data_base.rb
# BankDataBase class defined for
# storing all information about
# users, accounts, transactions
class BankDataBase
  attr_accessor :users, :accounts
  attr_accessor :deposits, :witdraws, :transfers

  def initialize(database = {})
    @users     = database.fetch(:users)
    @accounts  = database.fetch(:accounts)
    @deposits  = database.fetch(:deposits, nil)
    @witdraws  = database.fetch(:witdraws, nil)
    @transfers = database.fetch(:transfers, nil)
  end
  # TODO
end
