# frozen_string_literal: true

describe Paydesk do
  let(:bills_hash) do
    {
      500 => 1000,
      100 => 1000,
      50 => 1000,
      20 => 1000,
      10 => 1000,
      5 => 1000,
      1 => 1000
    }
  end
  let(:bills_result) do
    {
      500 => 754,
      100 => 996,
      50 => 999,
      20 => 1000,
      10 => 1000,
      5 => 999,
      1 => 999
    }
  end

  it 'returns expected hash' do
    expect(described_class.call(bills_hash, 123_456)).to eq(bills_result)
  end
end
