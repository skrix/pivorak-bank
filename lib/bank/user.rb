# frozen_string_literal: true

# user.rb
# User class defined for
# storing information about
# users
class User
  attr_accessor :user_id, :user_name, :password, :accounts

  def initialize(user_id, database)
    @user_id    = user_id
    @user_name  = database.fetch('users').fetch(user_id).fetch('name')
    @password   = database.fetch('users').fetch(user_id).fetch('password')
    @accounts   = accounts_owned(database)
  end

  def add_funds(amount, currency)
    accounts.keys.each do |account|
      accounts[account]['balance'] += amount if accounts[account]['currency'] == currency
    end
  end

  def sub_funds(amount, currency)
    accounts.keys.each do |account|
      accounts[account]['balance'] -= amount if accounts[account]['currency'] == currency
    end
  end

  private

  def accounts_owned(database = {})
    owner = {}
    all_accounts = database.fetch('accounts')

    all_accounts.keys.each do |account|
      owner[account] = all_accounts[account] if all_accounts[account]['user_id'] == user_id
    end
    owner
  end
end
