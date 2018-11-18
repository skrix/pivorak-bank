# frozen_string_literal: true

describe TransactionsPerformer do
  let(:data)      { Database.new(DB) }
  let(:user_id)   { 3321 }
  let(:source_id) { 123 }
  let(:amount)    { 99 }
  let(:currency)  { 'uah' }

  it 'make deposit' do
    service = described_class.new(data)
    service.make_deposit(user_id, amount, currency)
    expect(service.database.deposits).to eq(DB.fetch('deposits'))
  end
end
