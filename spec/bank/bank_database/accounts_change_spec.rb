# frozen_string_literal: true

require 'yaml'
require './lib/bank/bank_database'

describe BankDatabase do
  let(:config) do
    {
      'banknotes' => {},
      'users' => {},
      'accounts' => {
        123 => { 'currency' => 'uah', 'balance' => 139_66, 'user_id' => 3321 },
        124 => { 'currency' => 'usd', 'balance' => 143, 'user_id' => 3321 }
      },
      'deposits' => {},
      'withdraws' => {},
      'transfers' => {}
    }
  end
  let(:accounts) { config['accounts'] }
  let(:account) do
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
    accounts.merge!(account)
    expect(db.accounts).to eq(accounts)
  end
end
