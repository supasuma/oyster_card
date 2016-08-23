require 'station'

describe Station do

  subject(:station) { described_class.new}

  it 'initializes with name and zone on creation' do
    expect(station.name).to not_be_empty?
  end

end
