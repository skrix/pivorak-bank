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
  let!(:source_id) { 123 }
  let!(:target_id) { 123 }
  let!(:amount)    { 99 }
  let!(:currency)  { 'uah' }

  it 'make deposit' do
    service = described_class.new(data)
    service.make_deposit(user_id, amount, currency)
    expect(service.database.deposits).to eq(config.fetch('deposits'))
  end

  it 'make withdrawal' do
    service = described_class.new(data)
    service.make_withdraw(user_id, amount, currency)
    expect(service.database.withdraws).to eq(config.fetch('withdraws'))
  end

  it 'make transfer' do
    service = described_class.new(data)
    service.make_transfer(target_id, source_id, amount)
    expect(service.database.transfers).to eq(config.fetch('transfers'))
  end

  it 'check user_id' do
    service = described_class.new(data)
    expect(service.check_user_id(user_id)).to eq(config.fetch('users').fetch(user_id))
  end

  it 'check user name' do
    id = described_class.new(data).check_user_name(user_name)
    expect(id).to eq(user_id)
  end

  it 'check password' do
    check = described_class.new(data).check_password(user_id, user_pass)
    expect(check).to eq(true)
  end

  it 'check account' do
    account_check = described_class.new(data).check_account(user_id, currency)
    expect(account_check).to eq(source_id)
  end

  it 'check user balance' do
    uah_balance = described_class.new(data).user_balance(user_id).fetch('uah')
    expect(uah_balance).to eq(config.fetch('accounts').fetch(source_id).fetch('balance'))
  end
end
