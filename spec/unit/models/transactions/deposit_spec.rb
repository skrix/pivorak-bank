# frozen_string_literal: true

describe Deposit do
  let(:deposit_id) { 9999 }
  let(:amount) { 999_999 }
  let(:account_id) { 999 }

  let(:deposit) do
    {
        deposit_id =>
            {
                'amount' => amount,
                'account_id' => account_id
            }
    }
  end

  it 'created object have proper attributes' do
    deposit = described_class.new(deposit_id, account_id, amount)
    expect(deposit).to have_attributes(deposit_id: deposit_id,
                                       amount: amount,
                                       account_id: account_id)
  end

  it 'created object have proper attributes' do
    deposit = described_class.new(deposit_id, account_id)
    expect(deposit).to have_attributes(deposit_id: deposit_id,
                                       amount: 0,
                                       account_id: account_id)
  end

  it 'returns expected deposit hash (to_h method testing)' do
    expect(described_class.new(deposit_id, account_id, amount).to_h).to eq(deposit)
  end
end
