require 'journey'

describe Journey do

subject(:journey) { described_class.new(:entry_station => station) }
let(:station) { double :station }

  describe '#given an entry station' do

    it 'should have an entry station' do
      expect(journey.entry_station).to eq station
    end

  end

  describe '#finish' do

    it 'should return the exit station' do
      journey.finish("bye")
      expect(journey.exit_station).to eq "bye"
    end

    it 'should record the current journey' do
      expect(journey.current_journey).to include(:entry_station => station, :exit_station => station)
    end

  end

  describe '#fare' do

    it 'should return the minimum fare when finished journey' do
      journey.finish(station)
      expect(journey.fare).to eq Journey::MIN_FARE
    end

    it 'should be able to charge a penalty' do
      expect(journey.fare).to eq Journey::PEN_FARE
    end

    it'should check if a journey is complete' do
      journey.finish(station)
      expect(journey).to be_complete
    end

  end
end
