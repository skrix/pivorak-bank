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

  it 'created object have proper attributes' do
    account = described_class.new(account_id, options)
    expect(account).to have_attributes(account_id: account_id,
                                       currency: options.fetch('currency'),
                                       balance: options.fetch('balance'),
                                       user_id: options.fetch('user_id'))
  end
end
