# frozen_string_literal: true

require 'yaml'
require './lib/bank/bank_database'

describe BankDatabase do
  let(:config) do
    {
      'banknotes' => {
        'uah' => { 500 => 780, 200 => 0, 10 => 0, 5 => 10, 2 => 0, 1 => 50 },
        'usd' => { 500 => 20, 200 => 0, 100 => 0, 50 => 0, 2 => 0, 1 => 90 }
      },
      'users' => {
        3321 => { 'name' => 'Volodymyr', 'password' => 'mypass' },
        6128 => { 'name' => 'Bohdan', 'password' => 'p1v0rakru1eZZ!' }
      },
      'accounts' => {
        123 => { 'currency' => 'uah', 'balance' => 136, 'user_id' => 3321 },
        124 => { 'currency' => 'usd', 'balance' => 143, 'user_id' => 3321 }
      },
      'deposits' => { 1 => { 'amount' => 158, 'account_id' => 123 } },
      'withdraws' => { 1 => { 'amount' => 200, 'account_id' => 123 } },
      'transfers' => { 1 => { 'amount' => 100, 'source_account' => 123, 'target_account' => 156 } }
    }
  end

  it 'returns expected database in hash (to_h method testing)' do
    expect(described_class.new(config).to_h).to eq(config)
  end
end
