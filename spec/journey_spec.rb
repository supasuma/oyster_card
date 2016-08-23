require 'journey'

describe Journey do

let(:station1) { double :station1}
let(:station2) { double :station2}
#let(:exit_station) { double :exit_station}
let(:journey) {described_class.new(entry_station)}

  describe "#initialize" do
    it 'initializes with an entry_station' do
      expect(journey.entry_station).to eq station1
    end
  end

  describe "#exit_station" do
    it 'returns the value of the touched out station' do
      expect(journey.exit_station).to eq station2
    end
  end

  describe "#complete?" do
    it 'returns true if the journey is complete' do
      journey.exit_station(station2)
      expect(journey.complete?).to eq true
    end

    it 'returns false if the journey does not have an exit station' do
      expect(journey.complete?).to eq false
    end

  end

  describe '#fare' do
    it 'returns the fare if journey complete' do
      journey.exit_station(station2)
      expect(journey.fare).to eq Journey::MINIMUM_CHARGE
    end

    it 'returns penalty fare if journey incomplete' do
      expect(journey.fare).to eq Journey::PENALTY_CHARGE
    end

  end
end
