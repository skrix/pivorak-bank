# frozen_string_literal: true

require 'yaml'
require './lib/bank/bank_database'

describe BankDataBase do
  let!(:config) { YAML.load_file('./lib/config.yml') }
  let!(:deposit) do
    {
      5 =>
      {
        'amount'     => 999_999_999,
        'account_id' => 137
      }
    }
  end

  it 'add information about deposit bank_database' do
    db = described_class.new(config)
    db.deposits_update(deposit)
    config.fetch('deposits').merge!(deposit)
    expect(db.deposits).to eq(config.fetch('deposits'))
  end
end
