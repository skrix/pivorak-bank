# frozen_string_literal: true

require 'yaml'
require './lib/bank/deposit'

describe Deposit do
  let!(:deposit_id) { 9999 }
  let!(:account_id) { 999 }

  it 'created object have proper attributes' do
    deposit = described_class.new(deposit_id, account_id)
    expect(deposit).to have_attributes(deposit_id: deposit_id,
                                       amount: 0,
                                       account_id: account_id)
  end
end