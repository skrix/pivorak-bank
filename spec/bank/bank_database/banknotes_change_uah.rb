# frozen_string_literal: true

require 'yaml'
require './lib/bank/bank_database'

describe BankDatabase do
  let!(:config) { YAML.load_file('./lib/config.yml') }
  let!(:banknotes) do
    {
      'uah' => {
        5   => 1000,
        2   => 1000,
        1   => 1000
      }
    }
  end
  let!(:currency) { 'uah' }

  it 'change information about banknotes without full hash update uah' do
    db = described_class.new(config)
    db.banknotes_update(currency, banknotes.fetch(currency))
    config.fetch('banknotes').merge!(banknotes)
    expect(db.banknotes).to eq(config.fetch('banknotes'))
  end
end
