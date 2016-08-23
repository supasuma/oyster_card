require 'oystercard'

describe Oystercard do

  subject(:card) { described_class.new }
  let(:station) { double :station }

  it 'Describes an account when it is first opened' do
    expect(card.balance).to eq (0)
  end

  describe '#top_up' do
    it 'tops up Oystercard by amount 20' do
      expect { card.top_up(20) }.to change{card.balance}.by(20)
    end

    it 'raises an error when top up limit is exceeded' do
      maximum_limit = Oystercard::MAXIMUM_LIMIT
      card.top_up(maximum_limit)
      expect{ card.top_up(1) }.to raise_error 'Top up limited exceeded'
    end
  end

  describe 'touch_in' do
    it 'returns true when card touched in' do
      card.top_up(20)
      card.touch_in(station)
      expect(card).to be_in_journey
    end

    it 'raises error if balance is less than minimum required' do
      msg = "Insufficient funds. Please top up."
      expect{ card.touch_in(station) }.to raise_error msg
    end


    it 'record entry station upon touch in' do
      card.top_up(20)
      card.touch_in(station)
      expect(card.entry_station).to eq station
    end
  end

  describe 'touch_out' do

    before(:each) do
      card.top_up(20)
      card.touch_in(station)
      card.touch_out
    end

    it 'returns true when card touched out' do
      expect(card).to_not be_in_journey
    end
    it 'deducts fare when touching out' do
      expect { card.touch_out}.to change { card.balance }.by( -Oystercard::MINIMUM_LIMIT)
    end

    it 'forgets entry_station on touch out' do
      expect(card.entry_station).to eq nil 
    end

  end

  describe 'in_journey' do
    it 'card initializes with not in journey' do
      expect(card.in_journey?).to be false
    end
  end
end
