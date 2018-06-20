# frozen_string_literal: true

CONFIG = './lib/config.yml'

require 'yaml'
require './lib/bank/service'
require './lib/bank/bank_database'

describe Service do
  let!(:config)    { YAML.load_file(CONFIG) }
  let!(:data)      { BankDatabase.new(config) }
  let!(:user_id)   { 3321 }
  let!(:user_name) { 'Volodymyr' }
  let!(:user_pass) { 'mypass' }
  let!(:currency)  { 'uah' }
  let!(:source_id) { 123 }

  it 'check password' do
    check = described_class.new(data).check_password(user_id, user_pass)
    expect(check).to eq(true)
  end

  it 'check account' do
    account_check = described_class.new(data).check_account(user_id, currency)
    expect(account_check).to eq(source_id)
  end

  it 'check user balance' do
    uah_balance = described_class.new(data).user_balance(user_id).fetch(currency)
    expect(uah_balance).to eq(config.fetch('accounts').fetch(source_id).fetch('balance'))
  end
end
