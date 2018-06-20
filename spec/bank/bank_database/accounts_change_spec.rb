# frozen_string_literal: true

require 'yaml'
require './lib/bank/bank_database'

describe BankDatabase do
  let!(:config) { YAML.load_file('./lib/config.yml') }
  let!(:account) do
    {
      123 =>
      {
        'currency' => 'uah',
        'balance'  => 999_999_999,
        'user_id'  => 3321
      }
    }
  end

  it 'change information about account bank_database' do
    db = described_class.new(config)
    db.accounts_update(account)
    config.fetch('accounts').merge!(account)
    expect(db.accounts).to eq(config.fetch('accounts'))
  end
end
