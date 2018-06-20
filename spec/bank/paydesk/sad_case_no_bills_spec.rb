# frozen_string_literal: true

require './lib/bank/paydesk'

describe Paydesk do
  let(:bills_hash) { {} }

  it 'returns expected hash' do
    expect(described_class.new(bills_hash, 100).call).to eq(nil)
  end
end
