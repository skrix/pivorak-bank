# frozen_string_literal: true

require 'yaml'
require './lib/bank/bank_database'

describe BankDataBase do
  let!(:config) { YAML.load_file('./lib/config.yml') }
  let!(:banknotes) do
    {
      uah: {
        500 => 1000,
        200 => 1000,
        100 => 1000,
        50  => 1000,
        20  => 1000,
        10  => 1000,
        5   => 1000,
        2   => 1000,
        1   => 1000
      },
      usd: {
        500 => 100_000,
        200 => 100_000,
        100 => 100_000,
        50  => 100_000,
        20  => 100_000,
        10  => 100_000,
        5   => 100_000,
        2   => 100_000,
        1   => 100_000
      }
    }
  end

  it 'change information about banknotes bank_database' do
    db = described_class.new(config)
    db.banknotes_update(banknotes)
    config.fetch('banknotes').merge!(banknotes)
    expect(db.banknotes).to eq(config.fetch('banknotes'))
  end
end
