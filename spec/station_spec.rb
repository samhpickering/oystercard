require 'station'

describe Station do
  subject { described_class.new('Picadilly', 2) }

  it 'is initialized with 2 arguments' do
    expect(Station).to respond_to(:new).with(2).arguments
  end

  it 'knows its name' do
    expect(subject.name).to eq('Picadilly')
  end

  it 'knows its zone' do
    expect(subject.zone).to eq(2)
  end
end
