require 'oystercard'

describe Oystercard do
  it 'starts with a balance of zero' do
    expect(subject.balance).to eq 0
  end

  it 'adds the top-up value' do
    expect { subject.top_up(10) }.to change { subject.balance }.by(10)
  end

  it 'raised error if top up is over limit' do
    error_msg = "Top up would take card balance over £#{Oystercard::LIMIT} limit"
    expect { subject.top_up(Oystercard::LIMIT + 1) }.to raise_error error_msg
  end

  it 'deducts the amount given' do
    expect { subject.deduct(10) }.to change { subject.balance }.by(-10)
  end

  it 'starts as not in use' do
    expect(subject).to_not be_in_journey
  end

  it 'allows you to start a journey' do
    subject.top_up(2)
    subject.tap_in
    expect(subject).to be_in_journey
  end

  it 'allows you to end journey' do
    subject.top_up(2)
    subject.tap_in
    subject.tap_out
    expect(subject).to_not be_in_journey
  end

  it 'raises an error if tapped in when balance is below minimum' do
    expect { subject.tap_in }.to raise_error "Balance is below £#{Oystercard::MINIMUM} minimum"
  end
end
