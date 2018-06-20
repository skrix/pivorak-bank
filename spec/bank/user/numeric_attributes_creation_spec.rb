# frozen_string_literal: true

require 'yaml'
require './lib/bank/user'

describe User do
  let(:user_id) { 9999 }
  let(:options) do
    {
      'name' => 968_987,
      'password' => 6465
    }
  end

  it 'created object with numeric attributes' do
    account = described_class.new(user_id, options)
    expect(account).to have_attributes(user_id: user_id,
                                       user_name: options.fetch('name').to_s,
                                       password: options.fetch('password').to_s)
  end
end
