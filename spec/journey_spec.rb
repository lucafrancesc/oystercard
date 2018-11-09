require 'journey'

describe Journey do

  let(:entry_station){ double :entry_station }
  let(:exit_station){ double :exit_station }

  describe '#touched_in' do
    it 'equals nil if no station passed' do
      expect(subject.touched_in).to eq [nil]
    end
    it 'equals the entry_station' do
      expect(subject.touched_in(entry_station)).to eq [entry_station]
    end
  end

  describe '#touched_in' do
    it 'equals nil if no station passed' do
      expect(subject.touched_out).to eq [nil]
    end
    it 'equals the exit_station' do
      expect(subject.touched_in(exit_station)).to eq [exit_station]
    end
  end



end
