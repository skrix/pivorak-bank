# frozen_string_literal: true

require 'yaml'
require './lib/bank/transfer'

describe Transfer do
  let!(:transfer_id) { 9999 }
  let!(:amount) { 999_999 }
  let!(:source) { 111 }
  let!(:target) { 999 }

  it 'created object have proper attributes' do
    transfer = described_class.new(transfer_id, target, source, amount)
    expect(transfer).to have_attributes(transfer_id: transfer_id,
                                        amount: amount,
                                        source_account: source,
                                        target_account: target)
  end
end
