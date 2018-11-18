# frozen_string_literal: true

describe Paydesk do
  let(:bills_hash) { {} }

  it 'returns expected hash' do
    expect(described_class.call(bills_hash, 100)).to eq(nil)
  end
end
