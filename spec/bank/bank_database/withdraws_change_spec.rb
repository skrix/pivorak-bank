# frozen_string_literal: true

require 'yaml'
require './lib/bank/bank_database'

describe BankDatabase do
  let(:config) do
    {
      'banknotes' => {},
      'users' => {},
      'accounts' => {},
      'deposits' => {},
      'withdraws' => {
        1 => { 'amount' => 200, 'account_id' => 123 },
        2 => { 'amount' => 1655, 'account_id' => 123 }
      },
      'transfers' => {}
    }
  end
  let(:withdraws) { config['withdraws'] }
  let(:withdrawal) do
    {
      3 =>
      {
        'amount'     => 200,
        'account_id' => 123
      }
    }
  end

  it 'change information about account bank_database' do
    db = described_class.new(config)
    db.withdraws_update(withdrawal)
    withdraws.merge!(withdrawal)
    expect(db.withdraws).to eq(withdraws)
  end
end
