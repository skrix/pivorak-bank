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
      'withdraws' => {},
      'transfers' => {}
    }
  end
  let(:users) { config['users'] }
  let(:user) do
    {
      3321 =>
      {
        'name'     => 'Volodymyr',
        'password' => 'verystrongNEWpassword'
      }
    }
  end

  it 'change information about account bank_database' do
    db = described_class.new(config)
    db.users_update(user)
    users.merge!(user)
    expect(db.users).to eq(users)
  end
end
