require 'station'

describe Station do

  let(:station) { described_class.new('Victoria', 1) }
  it { expect(station.station_name).to eq 'Victoria'}
  it { expect(station.zone).to eq 1}

end
