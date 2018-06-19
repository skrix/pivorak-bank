# frozen_string_literal: true

require 'yaml'
require './lib/bank/account'

describe Account do
  let!(:account_id) { 9999 }
  let!(:amount) { 100 }
  let!(:options) do
    {
      'currency' => 'uah',
      'balance'  => 999_999,
      'user_id'  => 999
    }
  end

  it 'proper work of add_funds' do
    account = described_class.new(account_id, options)
    account.add_funds(amount)
    expect(account.balance).to eq(options.fetch('balance') + amount)
  end

  it 'proper work of sub_funds' do
    account = described_class.new(account_id, options)
    account.sub_funds(amount)
    expect(account.balance).to eq(options.fetch('balance') - amount)
  end
end
