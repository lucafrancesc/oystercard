require 'oystercard'

describe Oystercard do

  # let(:oyster2) { Oystercard.new(10.00) }
  let(:oyster) { Oystercard.new }
  let(:station){ double :station }
  describe '#balance' do
    it 'expects the default balance to be 0' do
      expect(oyster.balance).to eq 0.00
    end
  end

  describe '#top_up' do
    it 'expects the balance to be updated' do
      expect{ oyster.top_up(10.00) }.to change{ oyster.balance }.by 10.00
    end

    it 'raises an error if the card maximum balance is exceeded' do
      card_limit = Oystercard::CARD_LIMIT
      oyster.top_up(card_limit)
      expect { oyster.top_up(0.01) }.to raise_error "Card limit of #{card_limit} exceeded"
    end

    it 'raises an error if the top up amount is bigger than the card maximum' do
      card_limit = Oystercard::CARD_LIMIT
      expect { oyster.top_up(card_limit+1) }.to raise_error "Card limit of #{card_limit} exceeded"
    end
  end

  describe '#deduct' do

    it 'expects the balance to be updated' do
      oyster.top_up(10.00)
      oyster.touch_in(station)
      expect{ oyster.touch_out }.to change{ oyster.balance }.by -(Oystercard::MIN_FARE)
      expect(oyster).not_to be_in_journey
    end

    it 'raises an error if the balance is less than the min fare' do
      expect { oyster.touch_in(station) }.to raise_error 'Not enough credit'
    end

    it 'can touch in and expects to be in_journey' do
      oyster.top_up(10.00)
      oyster.touch_in(station)
      expect(oyster).to be_in_journey
    end

    it 'expects not be be in_journey(in use)' do
      expect(oyster).not_to be_in_journey
    end

    it 'expects oyster to set the station to nil' do
      # allow(oyster).to receive(:touch_out) { nil }
      oyster.touch_out
      expect(oyster.entry_station).to eq nil
    end
  end

  describe '#touch_in' do

    it 'expects oyster to remember the entry station' do
      # allow(oyster).to receive(:touch_in) { station }
      oyster.top_up(10.00)
      oyster.touch_in(station)
      expect(oyster.entry_station).to eq station
    end
  end

end
