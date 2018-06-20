# frozen_string_literal: true

require 'yaml'
require './lib/bank/bank_database'

describe BankDatabase do
  let(:config) do
    {
      'banknotes' => { 'usd' => { 500 => 980, 200 => 50, 5 => 189, 2 => 12, 1 => 0 } },
      'users' => {},
      'accounts' => {},
      'deposits' => {},
      'withdraws' => {},
      'transfers' => {}
    }
  end
  let(:bills) { config['banknotes'] }
  let(:banknotes) do
    {
      'usd' => {
        5   => 544,
        2   => 544,
        1   => 544
      }
    }
  end
  let(:currency) { 'usd' }

  it 'change information about banknotes without full hash update usd' do
    db = described_class.new(config)
    db.banknotes_update(currency, banknotes.fetch(currency))
    bills.merge!(banknotes)
    expect(db.banknotes).to eq(bills)
  end
end
