require 'oystercard'

describe Oystercard do

  subject(:oyster) { described_class.new }
  let(:station) { double :station }

  it 'initializes with a balance of 0' do
    expect(oyster.balance).to eq(0)
  end

  describe '#top_up' do

    it 'increases balance by amount' do
      oyster.top_up(10)
      expect(oyster.balance).to eq 10
    end

    context 'balance is greater than max limit' do

      it 'raises an error' do
        message = "balance cannot exceed £#{Oystercard::DEFAULT_MAX}"
        expect{oyster.top_up(Oystercard::DEFAULT_MAX+10)}.to raise_error message
      end

    end

  end

  describe '#touch_in' do

    context 'balance is greater than min balance' do

      subject(:oyster) {described_class.new(10)}

      it 'after touching in, in journey equals true' do
        oyster.touch_in(station)
        expect(oyster.in_journey?).to be(true)
      end

      it 'remembers which station entered' do
        oyster.touch_in(station)
        expect(oyster.entry_station).to eq(station)
      end

    end

    context 'balance is less than min balance' do

      it 'raises an error' do
        message = 'balance less than £1 - please top up'
        expect{oyster.touch_in(station)}.to raise_error message
      end

    end

  end

  describe '#touch_out' do

    before(:each) do
      oyster.top_up(10)
      oyster.touch_in(station)
    end

    it 'after touching out, in journey equals false' do
      oyster.touch_out
      expect(oyster.in_journey?).to be(false)
    end

    it 'deducts minimum fare from oyster' do
      expect {oyster.touch_out}.to change{oyster.balance}.by(-Oystercard::MIN_BALANCE)
    end

    it 'remembers which station exited' do
      oyster.touch_out(station)
      expect(oyster.exit_station).to eq(station)
    end

  end

end
