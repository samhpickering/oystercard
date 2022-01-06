require 'journey'

describe Journey do
  before :each do
    @start = double
    @end = double
  end

  describe '#start_point=' do
    it 'changes start_point' do
      expect { subject.start_point = @start }.to change { subject.start_point }.from(nil).to(@start)
    end
    it 'raises an error if the journey has already started' do
      subject.start_point = @start
      expect { subject.start_point = @start }.to raise_error 'Journey has already started'
    end
  end

  describe '#end_point=' do
    it 'changes end_point' do
      expect { subject.end_point = @end }.to change { subject.end_point }.from(nil).to(@end)
    end
    it 'raises an error if the journey is already complete' do
      subject.end_point = @end
      expect { subject.end_point = @end }.to raise_error 'Journey has already completed'
    end
  end

  describe '#fare' do
    it 'returns zero for an empty journey' do
      expect(subject.fare).to eq 0
    end
    it 'returns the minimum fare for a valid journey' do
      subject.start_point = @start
      subject.end_point = @end
      expect(subject.fare).to eq Journey::MINIMUM_FARE
    end
    it 'returns the penalty fare for an invalid journey' do
      subject.start_point = @start
      expect(subject.fare).to eq Journey::PENALTY_FARE
    end
  end

  describe '#valid?' do
    it 'changes to true when both start_point and end_point exist' do
      subject.start_point = @start
      expect { subject.end_point = @end }.to change { subject.valid? }.from(false).to(true)
    end
  end

  describe '#empty?' do
    it 'returns true for an empty journey' do
      expect(subject.empty?).to eq(true)
    end
    it 'returns false for a started journey' do
      subject.start_point = @start
      expect(subject.empty?).to eq(false)
    end
    it 'returns false for a completed journey' do
      subject.end_point = @end
      expect(subject.empty?).to eq(false)
    end
  end
end
