require 'oystercard'

describe Oystercard do
  it 'starts with a balance of zero' do
    expect(subject.balance).to eq 0
  end

  it 'adds the top-up value' do
    expect { subject.top_up(10) }.to change { subject.balance }.by(10)
  end

  it 'raised error if top up is over limit' do
    expect { subject.top_up( Oystercard::LIMIT + 1) }.to raise_error "Top up would take card balance over £#{Oystercard::LIMIT} limit"
  end

end
