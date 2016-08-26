require 'journey_log'

describe JourneyLog do

  subject(:journey_log) { described_class.new(journey_class: journey_class) }
  let(:journey_class) { double :journey_class, new: journey }
  let(:journey) { double :journey }
  let(:entry_station) { double :station }
  let(:exit_station) { double :station }

  describe '#start' do
    it 'should return a journey with an entry station' do
      expect(journey_log.start_journey(entry_station)).to eq journey
    end
  end

  describe '#finish' do

    let(:completed_journey) { double :completed_journey, entry_station: "Bank", exit_station: "Aldgate"}

    it 'records total journey' do
      #allow(:journey).to receive(:finish)#.and_return("Aldgate")
      journey_log2 = JourneyLog.new
      journey_log2.start_journey("Bank")
      journey_log2.finish_journey("Aldgate")
      expect(journey_log2.journey_history).to include(completed_journey)
    end

    xit 'records journey when touch out skipped' do
      journey_log.start_journey(entry_station)
      journey_log.start_journey(entry_station)
      expect(journey_log.journey_history).to include(journey)
    end

    xit 'records journey when touch in skipped' do
      journey_log.finish_journey(exit_station)
      expect(journey_log.journey_history).to include(journey)
    end

  end



end
