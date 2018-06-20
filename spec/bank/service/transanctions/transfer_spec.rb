# frozen_string_literal: true

CONFIG = './lib/config.yml'

require 'yaml'
require './lib/bank/service'
require './lib/bank/bank_database'

describe Service do
  let!(:config)    { YAML.load_file(CONFIG) }
  let!(:data)      { BankDatabase.new(config) }
  let!(:user_id)   { 3321 }
  let!(:user_name) { 'Volodymyr' }
  let!(:user_pass) { 'mypass' }
  let!(:source_id) { 123 }
  let!(:target_id) { 123 }
  let!(:amount)    { 99 }
  let!(:currency)  { 'uah' }

  it 'make transfer' do
    service = described_class.new(data)
    service.make_transfer(target_id, source_id, amount)
    expect(service.database.transfers).to eq(config.fetch('transfers'))
  end
end
