# frozen_string_literal: true

require 'yaml'
require './lib/bank/user'

describe User do
  let!(:user_id) { 9999 }
  let!(:options) do
    {
      'name' => 'Test',
      'password' => 'testtest'
    }
  end

  it 'created object with attributes by default' do
    account = described_class.new(user_id, options)
    expect(account).to have_attributes(user_id: user_id,
                                       user_name: options.fetch('name'),
                                       password: options.fetch('password'))
  end
end
