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

  it 'deducts the amount given' do
    expect { subject.deduct(10) }.to change { subject.balance }.by(-10)
  end

  it 'starts as not in use' do
    expect(subject).to_not be_in_journey
  end

  it 'allows you to start a journey' do
    subject.tap_in
    expect(subject).to be_in_journey
  end

  it 'allows you to end journey' do
    subject.tap_in
    subject.tap_out
    expect(subject).to_not be_in_journey
  end
end
