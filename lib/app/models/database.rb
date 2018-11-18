# frozen_string_literal: true

# bank_data_base.rb
# Database class defined for
# storing all information about
# users, accounts, transactions
class Database
  USERS       = 'users'
  BANKNOTES   = 'banknotes'
  ACCOUNTS    = 'accounts'
  DEPOSITS    = 'deposits'
  WITHDRAWALS = 'withdraws'
  TRANSFERS   = 'transfers'

  def initialize(database = {})
    @banknotes = database.fetch(BANKNOTES)
    @users     = database.fetch(USERS)
    @accounts  = database.fetch(ACCOUNTS)
    @deposits  = database.fetch(DEPOSITS, {})
    @withdraws = database.fetch(WITHDRAWALS, {})
    @transfers = database.fetch(TRANSFERS, {})
  end

  attr_reader :users,    :accounts, :banknotes,
              :deposits, :withdraws, :transfers

  def to_h
    {
      BANKNOTES   => banknotes,
      USERS       => users,
      ACCOUNTS    => accounts,
      DEPOSITS    => deposits,
      WITHDRAWALS => withdraws,
      TRANSFERS   => transfers
    }
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
