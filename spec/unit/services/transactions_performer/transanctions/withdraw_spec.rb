# frozen_string_literal: true

describe TransactionsPerformer do
  let(:data)      { Database.new(DB) }
  let(:user_id)   { 3321 }
  let(:source_id) { 123 }
  let(:amount)    { 99 }
  let(:currency)  { 'uah' }

  it 'make withdrawal' do
    service = described_class.new(data)
    service.make_withdraw(user_id, amount, currency)
    expect(service.database.withdraws).to eq(DB.fetch('withdraws'))
  end
end
