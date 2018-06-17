# frozen_string_literal: true

require 'yaml'

# bank_data_base.rb
# BankDataBase class defined for
# storing all information about
# users, accounts, transactions
class BankDataBase
  attr_reader :users,    :accounts, :banknotes
  attr_reader :deposits, :witdraws, :transfers

  def initialize(database = {})
    @banknotes = database.fetch('banknotes')
    @users     = database.fetch('users')
    @accounts  = database.fetch('accounts')
    @deposits  = database.fetch('deposits', {})
    @witdraws  = database.fetch('witdraws', {})
    @transfers = database.fetch('transfers', {})
  end

  def to_h
    Hash['banknotes' => banknotes, 'users' => users,
         'accounts' => accounts, 'deposits' => deposits,
         'witdraws' => witdraws, 'transfers' => transfers]
  end

  def banknotes=(options)
    banknotes.merge!(options)
  end

  def users=(options)
    users.merge!(options)
  end

  def accounts=(options)
    accounts.merge!(options)
  end

  def deposits=(options)
    deposits.merge!(options)
  end

  def witdraws=(options)
    witdraws.merge!(options)
  end

  def transfers=(options)
    transfers.merge!(options)
  end

  def update(config)
    File.open(config.to_s, 'r+') do |file|
      file.write(to_h.to_yaml)
    end
  end
end
