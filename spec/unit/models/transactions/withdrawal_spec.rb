# frozen_string_literal: true

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

  it 'created object have proper attributes' do
    withdrawal = described_class.new(withdraw_id, account_id)
    expect(withdrawal).to have_attributes(withdrawal_id: withdraw_id,
                                          amount: 0,
                                          account_id: account_id)
  end

  it 'created object have proper attributes' do
    withdrawal = described_class.new(withdraw_id, account_id, amount)
    expect(withdrawal).to have_attributes(withdrawal_id: withdraw_id,
                                          amount: amount,
                                          account_id: account_id)
  end
end
