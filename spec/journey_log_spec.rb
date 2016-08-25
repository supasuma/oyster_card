require 'journey_log'

describe JourneyLog do

  subject(:journey_log) { described_class.new(journey_class: journey_class) }
  let(:journey_class) { double :journey_class, new: journey }
  let(:journey) { double :journey }
  let(:entry_station) { double :station }
  let(:exit_station) { double :station }

  describe '#start' do
    it 'should return a journey with an entry station' do
      expect(journey_log.start(entry_station)).to eq journey
    end
  end

  describe '#finish' do
    it 'records total journey' do
      journey_log.start(entry_station)
      expect(journey_log.finish(exit_station)).to eq({ :entry_station => entry_station , :exit_station => exit_station })
    end
  end



end
