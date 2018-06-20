# frozen_string_literal: true

CONFIG = './lib/config.yml'

require 'yaml'
require './lib/bank/service'
require './lib/bank/bank_database'

describe Service do
  let(:config)    { YAML.load_file(CONFIG) }
  let(:data)      { BankDatabase.new(config) }
  let(:user_id)   { 3321 }
  let(:source_id) { 123 }
  let(:amount)    { 99 }
  let(:currency)  { 'uah' }

  it 'make withdrawal' do
    service = described_class.new(data)
    service.make_withdraw(user_id, amount, currency)
    expect(service.database.withdraws).to eq(config.fetch('withdraws'))
  end
end
