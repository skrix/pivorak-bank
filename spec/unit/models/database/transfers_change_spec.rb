# frozen_string_literal: true

describe Database do
  let(:config) do
    {
      'banknotes' => {},
      'users' => {},
      'accounts' => {},
      'deposits' => {},
      'withdraws' => {},
      'transfers' => {}
    }
  end
  let(:transfers) { config['transfers'] }
  let(:transfer) do
    {
      2 =>
      {
        'amount' => 999_999_999,
        'source_account'  => 123,
        'target_account'  => 156
      }
    }
  end

  it 'add information about new transfer database' do
    db = described_class.new(config)
    db.transfers_update(transfer)
    transfers.merge!(transfer)
    expect(db.transfers).to eq(transfers)
  end
end
