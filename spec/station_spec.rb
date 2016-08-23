require 'station'

describe Station do

  subject(:station) { described_class.new("Cockfosters", 80) }

  it 'initializes with name' do
    expect(station.name).to eq "Cockfosters"
  end

  it 'initializes with a zone' do
    expect(station.zone).to eq 80
  end
end
