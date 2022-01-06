require 'oystercard'

describe Oystercard do
  before :each do
    @station = double
    @station_out = double
  end

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

  it 'starts as not in use' do
    expect(subject).to_not be_in_journey
  end

  it 'allows you to start a journey' do
    subject.top_up(2)
    subject.tap_in(@station)
    expect(subject).to be_in_journey
  end

  it 'allows you to end journey' do
    subject.top_up(2)
    subject.tap_in(@station)
    subject.tap_out(@station_out)
    expect(subject).to_not be_in_journey
  end

  it 'raises an error if tapped in when balance is below minimum' do
    expect { subject.tap_in(@station) }.to raise_error RuntimeError
  end

  it 'deducts from balance when we tap out' do
    subject.top_up(2)
    subject.tap_in(@station)
    expect { subject.tap_out(@station_out) }.to change { subject.balance }.by_at_most(-1)
  end

  it 'remembers the station it was last tapped in at' do
    subject.top_up(2)
    subject.tap_in(@station)
    expect(subject.station).to eq(@station)
  end

  it 'card has an empty list of journeys by default' do
    expect(subject.history).to match_array([])
  end

  it 'adds a journey to the history when tapped in' do
    subject.top_up(2)
    expect { subject.tap_in(@station) }.to change { subject.history.length }.by(1)
  end
end
