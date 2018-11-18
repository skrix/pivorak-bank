# frozen_string_literal: true

describe TransactionsPerformer do
  let(:data)      { Database.new(DB) }
  let(:user_id)   { 3321 }
  let(:user_name) { 'Volodymyr' }
  let(:user_pass) { 'mypass' }
  let(:currency)  { 'uah' }
  let(:source_id) { 123 }

  it 'check password' do
    check = described_class.new(data).check_password(user_id, user_pass)
    expect(check).to eq(true)
  end

  it 'check account' do
    account_check = described_class.new(data).check_account(user_id, currency)
    expect(account_check).to eq(source_id)
  end

  it 'check user balance' do
    uah_balance = described_class.new(data).user_balance(user_id).fetch(currency)
    expect(uah_balance).to eq(DB.fetch('accounts').fetch(source_id).fetch('balance'))
  end
end
