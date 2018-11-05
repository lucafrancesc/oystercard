require 'oystercard'

describe Oystercard do

  describe '#balance' do
    it 'expects the default balance to be 0' do
      expect(subject.balance).to eq 0.00
    end
  end

  describe '#top_up' do
    it 'expects the balance to be updated' do
      expect{ subject.top_up(10.00) }.to change{ subject.balance }.by 10.00
    end

    it 'raises an error if the card maximum balance is exceeded' do
      card_limit = Oystercard::CARD_LIMIT
      subject.top_up(card_limit)
      expect { subject.top_up(0.01) }.to raise_error "Card limit of #{card_limit} exceeded"
    end

    it 'raises an error if the top up amount is bigger than the card maximum' do
      card_limit = Oystercard::CARD_LIMIT
      expect { subject.top_up(card_limit+1) }.to raise_error "Card limit of #{card_limit} exceeded"
    end
  end

  describe '#deduct' do
    it 'expects the balance to be updated' do
      subject.top_up(10.00)
      subject.touch_in
      subject.touch_out
      expect{ subject.deduct }.to change{ subject.balance }.by -(Oystercard::MIN_FARE)
      expect(subject).not_to be_in_journey
    end

    it 'raises an error if the balance is less than the min fare' do
      expect { subject.touch_in }.to raise_error 'Not enough credit'
    end

    it 'can touch in and expects to be in_journey' do
      subject.top_up(10.00)
      subject.touch_in
      expect(subject).to be_in_journey
    end

    it 'expects not be be in_journey(in use)' do
      expect(subject).not_to be_in_journey
    end

  end

end
