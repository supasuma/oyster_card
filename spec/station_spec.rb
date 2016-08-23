require 'station'

describe Station do

  subject(:station) { described_class.new}

  it 'initializes with name' do
    expect(station.name).not_to be_nil
  end

  it 'initializes with a zone' do
    expect(station.zone).not_to be_nil
  end
end
