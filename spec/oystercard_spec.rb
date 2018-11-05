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
  end

end
