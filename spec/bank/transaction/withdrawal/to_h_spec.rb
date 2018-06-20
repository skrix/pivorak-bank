# frozen_string_literal: true

require 'yaml'
require './lib/bank/withdrawal'

describe Withdrawal do
  let(:withdraw_id) { 9999 }
  let(:amount) { 999_999 }
  let(:account_id) { 999 }

  let(:withdraw) do
    {
      withdraw_id =>
      {
        'amount' => amount,
        'account_id' => account_id
      }
    }
  end

  it 'returns expected withdrawal hash (to_h method testing)' do
    expect(described_class.new(withdraw_id, account_id, amount).to_h).to eq(withdraw)
  end
end
