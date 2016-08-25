require 'journey_log'

describe JourneyLog do

  subject(:journey_log) { described_class.new(journey_class: journey_class) }
  let(:journey_class) { double :journey, new: entry_station }
  let(:entry_station) { double :station }

  describe '#start' do
    it 'should return a journey with an entry station' do
      expect(journey_log.start(entry_station)).to eq entry_station
    end
  end

end
