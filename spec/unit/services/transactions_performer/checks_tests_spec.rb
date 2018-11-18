# frozen_string_literal: true

describe TransactionsPerformer do
  let(:data)      { Database.new(DB) }
  let(:user_id)   { 3321 }
  let(:user_name) { 'Volodymyr' }

  it 'check user_id' do
    service = described_class.new(data)
    expect(service.check_user_id(user_id)).to eq(DB.fetch('users').fetch(user_id))
  end

  it 'check user name' do
    id = described_class.new(data).check_user_name(user_name)
    expect(id).to eq(user_id)
  end
end
