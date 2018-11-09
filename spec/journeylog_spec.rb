require 'journeylog'

describe JourneyLog do

  let(:entry_station){ double :entry_station }
  let(:exit_station){ double :exit_station }
  #
  # expect(subject).to respond_to(:start)
  # expect(subject).to respond_to(:finish)

  describe '#journeys' do

    it 'shows an empty arrays' do
      subject.start
      subject.finish
      expect(subject.journeys).to eq [{:entry_station=>nil, :exit_station=>nil}]
    end
    it 'shows the journeys made' do
      subject.start entry_station
      subject.finish exit_station
      expect(subject.journeys).to eq [{:entry_station=>entry_station, :exit_station=>exit_station}]
    end
  end

end
