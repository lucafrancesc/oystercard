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

end
