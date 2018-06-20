# frozen_string_literal: true

require 'yaml'
require './lib/bank/withdrawal'

describe Withdrawal do
  let(:withdraw_id) { 9999 }
  let(:account_id) { 999 }

  it 'created object have proper attributes' do
    withdrawal = described_class.new(withdraw_id, account_id)
    expect(withdrawal).to have_attributes(withdrawal_id: withdraw_id,
                                          amount: 0,
                                          account_id: account_id)
  end
end
