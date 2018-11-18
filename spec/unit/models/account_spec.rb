# frozen_string_literal: true

describe Account do
  let(:default) do
    {
      'user_id' => 999
    }
  end
  let(:account_id) { 9999 }
  let(:amount) { 100 }
  let(:options) do
    {
        'currency' => 'uah',
        'balance'  => 999_999,
        'user_id'  => 999
    }
  end
  let(:account) { described_class.new(account_id, options) }


  it 'created object have proper attributes' do
    account = described_class.new(account_id, options)

    expect(account).to have_attributes(account_id: account_id,
                                       currency: options.fetch('currency'),
                                       balance: options.fetch('balance'),
                                       user_id: options.fetch('user_id'))
  end

  it 'created object with attributes by default' do
    account = described_class.new(account_id, default)

    expect(account).to have_attributes(account_id: account_id, currency: 'uah',
                                       balance: 0, user_id: options.fetch('user_id'))
  end

  it 'proper work of add_funds' do
    account.add_funds(amount)
    expect(account.balance).to eq(options.fetch('balance') + amount)
  end

  it 'proper work of sub_funds' do
    account.sub_funds(amount)
    expect(account.balance).to eq(options.fetch('balance') - amount)
  end

  it 'returns expected account hash (to_h method testing)' do
    expect(described_class.new(account_id, options).to_h).to eq(account.to_h)
  end
end