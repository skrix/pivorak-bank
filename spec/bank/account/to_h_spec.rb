# frozen_string_literal: true

require 'yaml'
require './lib/bank/account'

describe Account do
  let(:account_id) { 9999 }
  let(:options) do
    {
      'currency' => 'uah',
      'balance'  => 999_999,
      'user_id'  => 999
    }
  end
  let(:account) do
    {
      9999 =>
      {
        'currency' => 'uah',
        'balance'  => 999_999,
        'user_id'  => 999
      }
    }
  end

  it 'returns expected account hash (to_h method testing)' do
    expect(described_class.new(account_id, options).to_h).to eq(account)
  end
end
