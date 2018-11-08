require 'journey'
require 'oystercard'

describe Journey do
  let(:entry_station) { double :station }
  let(:exit_station) { double :station }
  let(:oyster) { Oystercard.new 10}
  it { is_expected.to respond_to :fare }
  it { is_expected.to respond_to :finish }

  describe '#complete' do

    it 'return false if user failed to  out' do
      subject.touched_in entry_station
      expect(subject.complete?).to eq false
    end

    it 'return false if user failed to touch_in ' do
      subject.touched_out exit_station
      expect(subject.complete?).to eq false
    end

    it 'return true if user touches_in or out' do
      subject.touched_in entry_station
      subject.touched_out exit_station
      expect(subject.complete?).to eq true
    end

    it 'checks wether to apply the fair or the fine' do
      subject.touched_out entry_station
      expect(subject.fare).to eq Journey::FINE
    end

    it 'checks wether to apply the fair or the fine' do
      subject.touched_in entry_station
      subject.touched_out exit_station
      expect(subject.fare).to eq Journey::MIN_FARE
    end

    it 'return an empty array at the beginning' do
      expect(subject.journeys).to eq []
    end

    it 'return an array of ashes' do
      subject.touched_in entry_station
      subject.touched_out exit_station
      subject.finish
      expect(subject.journeys).to eq [{entry_station: entry_station, exit_station: exit_station}]
    end

  end
end
