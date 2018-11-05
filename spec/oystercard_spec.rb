require 'oystercard'

describe Oystercard do

  describe '#balance' do
    it 'expects the default balance to be 0' do
      expect(subject.balance).to eq 0
    end
  end

  

end
