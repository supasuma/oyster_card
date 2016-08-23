require 'journey'

describe Journey do

  subject(:journey) { described_class.new }

  describe '#given an entry station' do

  let(:entry_station) { double :station }

    it 'should have an entry station' do
      expect(journey.entry_station).to eq entry_station
    end

  end

end
