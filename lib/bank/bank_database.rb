# frozen_string_literal: true

require 'yaml'

# bank_data_base.rb
# BankDatabase class defined for
# storing all information about
# users, accounts, transactions
class BankDatabase
  attr_reader :users,    :accounts, :banknotes
  attr_reader :deposits, :withdraws, :transfers

  def initialize(database = {})
    @banknotes = database.fetch('banknotes')
    @users     = database.fetch('users')
    @accounts  = database.fetch('accounts')
    @deposits  = database.fetch('deposits', {})
    @withdraws = database.fetch('withdraws', {})
    @transfers = database.fetch('transfers', {})
  end

  def to_h
    Hash['banknotes' => banknotes, 'users' => users,
         'accounts' => accounts, 'deposits' => deposits,
         'withdraws' => withdraws, 'transfers' => transfers]
  end

  def banknotes_update(currency, options)
    @banknotes.fetch(currency).merge!(options)
  end

  def users_update(options)
    @users.merge!(options)
  end

  def accounts_update(options)
    @accounts.merge!(options)
  end

  def deposits_update(options)
    deposits.merge!(options)
  end

  def withdraws_update(options)
    withdraws.merge!(options)
  end

  def transfers_update(options)
    transfers.merge!(options)
  end

  def update(config)
    File.open(config.to_s, 'r+') do |file|
      file.write(to_h.to_yaml)
    end
  end
end
