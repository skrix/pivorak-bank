# frozen_string_literal: true

require 'yaml'
require './lib/bank/bank_database'

describe BankDatabase do
  let(:config) { YAML.load_file('./lib/config.yml') }
  let(:withdrawal) do
    {
      2 =>
      {
        'amount'     => 200,
        'account_id' => 123
      }
    }
  end

  it 'change information about account bank_database' do
    db = described_class.new(config)
    db.withdraws_update(withdrawal)
    config.fetch('withdraws').merge!(withdrawal)
    expect(db.withdraws).to eq(config.fetch('withdraws'))
  end
end
