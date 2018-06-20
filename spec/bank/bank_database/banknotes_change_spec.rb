# frozen_string_literal: true

require 'yaml'
require './lib/bank/bank_database'

describe BankDatabase do
  let(:config) do
    {
      'banknotes' => { 'uah' => { 500 => 90, 200 => 50, 5 => 189, 2 => 12, 1 => 0 } },
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
      'uah' => {
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
    db.banknotes_update(currency, bills.fetch(currency))
    bills.merge!(banknotes)
    expect(db.banknotes).to eq(bills)
  end
end
