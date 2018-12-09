# frozen_string_literal: true

describe User do
  let(:user_id) { 9999 }

  context 'with string attributes' do
    let(:options) do
      {
        'name' => 'Test',
        'password' => 'testtest'
      }
    end

    it 'created object' do
      account = described_class.new(user_id, options)
      expect(account).to have_attributes(user_id: user_id,
                                         user_name: options.fetch('name'),
                                         password: options.fetch('password'))
      end
  end

  context 'with numeric attributes' do
    let(:options) do
      {
          'name' => 968_987,
          'password' => 6465
      }
    end

    it 'created object' do
      account = described_class.new(user_id, options)
      expect(account).to have_attributes(user_id: user_id,
                                         user_name: options.fetch('name').to_s,
                                         password: options.fetch('password').to_s)
    end
  end
end
