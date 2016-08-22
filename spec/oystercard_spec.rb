require 'oystercard'

describe Oystercard do

  subject(:oyster) { described_class.new }

  it 'initializes with a balance of 0' do
    expect(oyster.balance).to eq(0)
  end

  describe '#top_up' do

    it{is_expected.to respond_to(:top_up).with(1).argument}

    it 'increases balance by amount' do
      oyster.top_up(10)
      expect(oyster.balance).to eq 10
    end

    context 'balance is greater than max limit' do

      it 'raises an error' do
        message = "balance cannot exceed #{Oystercard::DEFAULT_MAX}"
        expect{oyster.top_up(Oystercard::DEFAULT_MAX+10)}.to raise_error message
      end
    end
  end

  describe '#deduct' do

    it 'reduces balance by amount' do
      oyster.top_up(40)
      oyster.deduct(10)
      expect(oyster.balance).to eq(30)
    end

  end

  it { is_expected.to respond_to(:in_journey?)}

  it 'when touching in, in journey equals true' do
    oyster.touch_in
    expect(oyster.in_journey?).to be(true)
  end

end
