require 'journey'

describe Journey do

  let(:entry_station){ double :entry_station }
  let(:exit_station){ double :exit_station }

  describe '#touched_in' do
    it 'equals nil if no station passed' do
      expect(subject.touched_in).to eq nil
    end
    it 'equals the entry_station' do
      expect(subject.touched_in(entry_station)).to eq [entry_station]
    end
  end

  describe '#touched_in' do

    it 'equals nil if no station passed' do
      expect(subject.touched_out).to eq nil
    end
    it 'equals the exit_station' do
      expect(subject.touched_in(exit_station)).to eq [exit_station]
    end

  end

  describe '#journey' do

    it 'equals nil if no station passed' do
      subject.touched_in
      subject.touched_out
      expect(subject.journey).to eq []
    end
    it 'equals nil if no station passed' do
      subject.touched_in entry_station
      subject.touched_out exit_station
      expect(subject.journey).to eq [entry_station, exit_station]
    end

end

  describe '#complete?' do

    it 'equals nil if one station is not passed' do
      subject.touched_in
      subject.touched_out exit_station
      expect(subject.complete?).to eq nil
    end

    it 'equals nil if one station is not passed' do
      subject.touched_in entry_station
      subject.touched_out
      expect(subject.complete?).to eq nil
    end

    it 'equals true if no station passed' do
      subject.touched_in entry_station
      subject.touched_out exit_station
      expect(subject.complete?).to eq true
    end
  end

  describe '#fare' do

    it 'returns the min fare if complete' do
      subject.touched_in entry_station
      subject.touched_out exit_station
      expect(subject.complete?).to eq true
      expect(subject.fare).to eq Journey::MIN_FARE

    end

    it 'returns the fine if incomplete' do
      subject.touched_in
      subject.touched_out exit_station
      expect(subject.complete?).to eq nil
      expect(subject.fare).to eq Journey::FINE

    end
  end

end
