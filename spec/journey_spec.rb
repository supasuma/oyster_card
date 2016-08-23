require 'journey'

describe Journey do

let(:station1) { double :station1}
let(:station2) { double :station2}
let(:journey1) {described_class.new(station1, nil)}
let(:journey2) {described_class.new(nil, station2)}


  describe "#finish" do
    it 'returns the value of the touched out station' do
      journey1.finish(station2)
      expect(journey1.exit_station).to eq station2
    end
  end

  describe "#complete?" do
    it 'returns true if the journey is complete' do
      journey1.finish(station2)
      expect(journey1).to be_complete
    end

    it 'returns false if the journey does not have an exit station' do
      expect(journey1).not_to be_complete
    end

    it "returns false if the journey does not have an entry station" do
      expect(journey2).not_to be_complete
    end

  end

  describe '#fare' do
    it 'returns the fare if journey complete' do
      journey1.finish(station2)
      expect(journey1.fare).to eq Journey::MINIMUM_CHARGE
    end

    it 'returns penalty fare if journey incomplete' do
      expect(journey1.fare).to eq Journey::PENALTY_CHARGE
    end

  end
end
