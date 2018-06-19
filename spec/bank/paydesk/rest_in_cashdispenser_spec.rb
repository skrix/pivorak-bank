# frozen_string_literal: true

require './lib/bank/paydesk'

describe Paydesk do
  let!(:bills_hash) do
    {
      500 => 1000,
      100 => 1000,
      50 => 1000,
      20 => 1000,
      10 => 1000,
      5 => 1000,
      2 => 1000,
      1 => 1000
    }
  end

  it 'returns expected hash' do
    expect(described_class.new(bills_hash, 123_456).call).to eq(
      500 => 754,
      100 => 996,
      50 => 999,
      20 => 1000,
      10 => 1000,
      5 => 999,
      2 => 1000,
      1 => 999
    )
  end
end
