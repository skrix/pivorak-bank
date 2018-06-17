# frozen_string_literal: true

require 'yaml'
require './lib/bank/bank_database'

describe BankDataBase do
  let!(:config) { YAML.load_file('./lib/config.yml') }
  let!(:user) do
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
    config.fetch('users').merge!(user)
    expect(db.users).to eq(config.fetch('users'))
  end
end
