# frozen_string_literal: true

require 'yaml'
require './lib/bank/transfer'

describe Transfer do
  let!(:transfer_id) { 9999 }
  let!(:amount) { 999_999 }
  let!(:source) { 111 }
  let!(:target) { 999 }

  let!(:transfer) do
    {
      transfer_id =>
      {
        'amount'         => amount,
        'source_account' => source,
        'target_account' => target
      }
    }
  end

  it 'returns expected transfer hash (to_h method testing)' do
    expect(described_class.new(transfer_id, target, source, amount).to_h).to eq(transfer)
  end
end
