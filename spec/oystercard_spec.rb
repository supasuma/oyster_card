
require 'oystercard.rb'

describe Oystercard do

  subject(:oystercard) { described_class.new }
  let(:station) { double :station }
  let(:station2) { double :station2 }

  it 'checks default balance of Oystercard is 0' do
    expect(oystercard.balance).to eq 0
  end

  describe '#top_up' do

    before do
      oystercard.top_up(Oystercard::BALANCE_LIMIT)
    end

    it 'will not allow a balance to exceed 90' do
      expect{ oystercard.top_up 1 }.to raise_error "Your top up will exceed balance limit of #{Oystercard::BALANCE_LIMIT}!"
    end

    # it 'adds money to my oyster card' do
    #   expect{ oystercard.top_up 1 }.to change{ oystercard.balance }.by 1
    # end

  end

  describe '#in_journey?' do

    it 'is initially not in journey' do
      expect(oystercard).not_to be_in_journey
    end

  end

  describe '#touch_in(station)' do

    before do
      oystercard.top_up(Oystercard::MIN_FARE)
    end

    it 'raises an error if minimum balance on oystercard is less than 1' do
      oystercard.touch_in(station)
      oystercard.touch_out(station)
      expect{oystercard.touch_in(station)}.to raise_error 'you have insufficient funds on your oystercard'
    end

    it 'updates in_journey to true' do
      oystercard.touch_in(station)
      expect(oystercard).to be_in_journey
    end

    it 'updates & stores entry_station' do
      oystercard.touch_in(station)
      expect(subject.entry_station).to eq station
    end

  end

  describe '#touch_out(station)' do
    before do
      oystercard.top_up(Oystercard::MIN_FARE)
      oystercard.touch_in(station)
    end

    it 'updates in_journey to false' do
      oystercard.touch_out(station)
      expect(oystercard).not_to be_in_journey
    end

    it 'updates balance by deducting fare' do
      expect{ oystercard.touch_out(station) }.to change{ oystercard.balance }.by (-Oystercard::MIN_FARE)
    end

    it 'updates & stores exit_station' do
      oystercard.touch_out(station)
      expect(oystercard.exit_station).to eq station
    end

    it 'stores journey as a hash in array' do
      oystercard.touch_out(station2)
      expect(oystercard.journeys).to eq [{entry_station: station, exit_station: station2}]
    end

  end

end
