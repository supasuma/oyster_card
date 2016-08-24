require 'journey'

# Let's create a new Journey class, it should be responsible for starting a journey, finishing a journey,
# calculating the fare of a journey, and returning whether or not the journey is complete.

describe Journey do

  subject(:journey) { described_class.new ("Bank") }
  let(:card) { double :oystercard }

  describe '#initialize' do
    it 'initializes with an recorded entry station' do
      expect(journey.entry_station).to eq "Bank"
    end
  end

  describe '#finish_journey' do
    it 'records total journey' do
      expect(journey.finish_journey("Aldgate")).to eq({ :entry_station => "Bank" , :exit_station => "Aldgate" })
    end
  end


end
