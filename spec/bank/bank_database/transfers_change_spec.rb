# frozen_string_literal: true

require 'yaml'
require './lib/bank/bank_database'

describe BankDatabase do
  let(:config) { YAML.load_file('./lib/config.yml') }
  let(:transfer) do
    {
      2 =>
      {
        'amount' => 999_999_999,
        'source_account'  => 123,
        'target_account'  => 156
      }
    }
  end

  it 'add information about new transfer bank_database' do
    db = described_class.new(config)
    db.transfers_update(transfer)
    config.fetch('transfers').merge!(transfer)
    expect(db.transfers).to eq(config.fetch('transfers'))
  end
end
