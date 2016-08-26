require 'oystercard'

describe Oystercard do

  subject(:empty_card) { described_class.new }
  subject(:card) { described_class.new }

  let(:entry_station) { double :station }
  let(:exit_station) { double :station }

  before do
    card.top_up(20)
  end

  it 'Describes an account when it is first opened' do
    expect(empty_card.balance).to eq (0)
  end


  describe '#top_up' do
    it 'tops up Oystercard by amount 20' do
      expect { empty_card.top_up(20) }.to change{empty_card.balance}.by(20)
    end

    it 'raises an error when top up limit is exceeded' do
      maximum_limit = Oystercard::MAXIMUM_LIMIT
      empty_card.top_up(maximum_limit)
      expect{ empty_card.top_up(1) }.to raise_error 'Top up limited exceeded'
    end
  end

  describe '#touch_in' do
    it 'raises error if balance is less than minimum required' do
      msg = "Insufficient funds. Please top up."
      expect{ empty_card.touch_in(entry_station) }.to raise_error msg
    end

    it 'initiates a journey on touching in' do
      expect(card.touch_in(entry_station)).to eq card.journey
    end

    context 'touching in when previous journey is incomplete' do
      it 'charges penalty fare to the balance' do
        card.touch_in(entry_station)
        expect{card.touch_in(entry_station)}.to change {card.balance}.by(-6)
      end

      # it 'add a incomplete journey to journey history' do
      #   card.touch_in(entry_station)
      #   card.touch_in(entry_station)
      #   expect(card.journeys).to include({ :entry_station => entry_station , :exit_station => nil })
      # end
    end

  end

  describe '#touch_out' do

    before(:each) do
      card.touch_in(entry_station)
      card.touch_out(exit_station)
    end

    it 'deducts normal journey fare when touching out' do
      card.touch_in(entry_station)
      expect { card.touch_out(exit_station)}.to change { card.balance }.by( -Oystercard::MINIMUM_LIMIT)
    end


    it 'forgets entry_station on touch out' do
      expect(card.journey).to eq nil
    end

    context 'touching out when card has not been touched in' do
      it 'charges a penalty fare to the balance' do
        expect{card.touch_out(exit_station)}.to change {card.balance}.by(-6)
      end

      # it 'records incomplete journey in journey history' do
      #   card.touch_out(exit_station)
      #   expect(card.journeys).to include({ :entry_station => nil , :exit_station => exit_station })
      # end
    end

  end
end
