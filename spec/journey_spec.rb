require 'journey'

describe Journey do

let(:entry_station) { double :station }
let(:exit_station) { double :station}

  describe '#given an entry station' do

    subject(:journey) { described_class.new(entry_station) }

    it 'should have an entry station' do
      expect(journey.entry_station).to eq entry_station
    end

  end

  describe '#given an exit station' do
    subject(:journey) { described_class.new(entry_station) }
    it 'should have an exit station' do
      expect(journey.exit_station).to eq exit_station
    end
  end
end
