# frozen_string_literal: true

require 'yaml'
require './lib/bank/bank_database'

describe BankDatabase do
  let(:config) { YAML.load_file('./lib/config.yml') }
  let(:banknotes) do
    {
      'uah' => {
        500 => 1000,
        200 => 1000,
        100 => 1000,
        50  => 1000,
        20  => 1000,
        10  => 1000,
        5   => 1000,
        2   => 1000,
        1   => 1000
      }
    }
  end
  let(:currency) { 'uah' }

  it 'change information about banknotes in database with full hash' do
    db = described_class.new(config)
    db.banknotes_update(currency, banknotes.fetch(currency))
    config.fetch('banknotes').merge!(banknotes)
    expect(db.banknotes).to eq(config.fetch('banknotes'))
  end
end
