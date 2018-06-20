# frozen_string_literal: true

require 'yaml'
require './lib/bank/bank_database'

describe BankDatabase do
  let(:config) { YAML.load_file('./lib/config.yml') }

  it 'returns expected database in hash (to_h method testing)' do
    expect(described_class.new(config).to_h).to eq(config)
  end
end
