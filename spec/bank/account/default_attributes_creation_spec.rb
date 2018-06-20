# frozen_string_literal: true

require 'yaml'
require './lib/bank/account'

describe Account do
  let(:account_id) { 9999 }
  let(:options) do
    {
      'user_id' => 999
    }
  end

  it 'created object with attributes by default' do
    account = described_class.new(account_id, options)
    expect(account).to have_attributes(account_id: account_id,
                                       currency: 'uah',
                                       balance: 0,
                                       user_id: options.fetch('user_id'))
  end
end
