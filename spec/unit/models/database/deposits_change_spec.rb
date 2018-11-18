# frozen_string_literal: true

describe Database do
  let(:config) do
    {
      'banknotes' => {},
      'users' => {},
      'accounts' => {},
      'deposits' => {
        1 => { 'amount' => 1578, 'account_id' => 123 },
        2 => { 'amount' => 1435, 'account_id' => 124 },
        3 => { 'amount' => 2567, 'account_id' => 136 }
      },
      'withdraws' => {},
      'transfers' => {}
    }
  end
  let(:deposits) { config['deposits'] }
  let(:deposit) do
    {
      4 => { 'amount' => 999_999_999, 'account_id' => 137 }
    }
  end

  it 'add information about deposit database' do
    db = described_class.new(config)
    db.deposits_update(deposit)
    deposits.merge!(deposit)
    expect(db.deposits).to eq(deposits)
  end
end
