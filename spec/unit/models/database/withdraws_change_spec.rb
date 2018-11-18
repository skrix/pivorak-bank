# frozen_string_literal: true

describe Database do
  let(:config) do
    {
      'banknotes' => {},
      'users' => {},
      'accounts' => {},
      'deposits' => {},
      'withdraws' => {
        1 => { 'amount' => 200, 'account_id' => 123 },
        2 => { 'amount' => 1655, 'account_id' => 123 }
      },
      'transfers' => {}
    }
  end
  let(:withdraws) { config['withdraws'] }
  let(:withdrawal) do
    {
      3 =>
      {
        'amount'     => 200,
        'account_id' => 123
      }
    }
  end

  it 'change information about account database' do
    db = described_class.new(config)
    db.withdraws_update(withdrawal)
    withdraws.merge!(withdrawal)
    expect(db.withdraws).to eq(withdraws)
  end
end
