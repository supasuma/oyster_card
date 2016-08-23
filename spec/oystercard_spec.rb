require 'oystercard'

describe Oystercard do

  subject(:card) {described_class.new}
  subject(:other_card) {described_class.new}

  let(:station) {double :station}
  let(:station2) {double :station2}

  before(:each) do
    card.top_up(10)
  end

  describe "initialize" do
    it "creates an instance of the card and the balance should be zero" do
      expect(other_card.balance).to eq 0
    end

    it "creates an in_journey instance variable with default of false" do
      expect(card.in_journey?).to eq false
    end

    it "creates an empty array of stations" do
      expect(card.journeys).to be_empty
    end

  end

  describe "#top_up" do
#    it "responds to a method call with 1 argument" do
#      expect(card).to respond_to(:top_up).with(1).arguments
#    end

    it "adds an amount to the balance" do
      other_card.top_up(10)
      expect(card.balance).to eq 10
    end

    it "raises an error when more than the max amount is topped up" do
      top_up_amount = Oystercard::MAXIMUM_BALANCE+1
      expect{card.top_up(top_up_amount)}.to raise_error(RuntimeError)
    end
  end

  # describe "#deduct" do
  #   it "responds to a method call with 1 argument" do
  #     expect(card).to respond_to(:deduct).with(1).arguments
  #   end
  #
  #   it "deducts an amount from the balance" do
  #     card.top_up(20)
  #     expect{card.deduct(10)}.to change(card, :balance).from(30).to(20)
  #   end
  # end

  describe "#in_journey?" do
#    it "responds to method call" do
#      expect(card).to respond_to :in_journey?
#    end

    it "returns false if we call it after instantiated the instance" do
      expect(card).not_to be_in_journey
    end
  end

  describe "#touch_in" do

#    it "responds to method call" do
#      expect(card).to respond_to(:touch_in).with(1).arguments
#    end

    it "change the in_journey instance variable to true " do
      card.touch_in(station)
      expect(card).to be_in_journey
    end

    it "raises an error when try to touch in with balance less than £1" do
      amount = Oystercard::MINIMUM_BALANCE - 0.5
      other_card.top_up(amount)
      expect{other_card.touch_in(station)}.to raise_error(RuntimeError)
    end

    it "remembers the station that was entered when touching in" do
      card.touch_in(station)
      expect(card.entry_station).to eq station
    end

  end

  describe "#touch_out" do
    before(:each) do
      card.touch_in(station)
    end

#    it "responds to method call" do
#      expect(card).to respond_to(:touch_out).with(1).arguments
#    end

    it "changes the in_journey ivar to false" do
      card.touch_out(station)
      expect(card).not_to be_in_journey
    end

    it "deducts MINIMUM_CHARGE from your card balance" do
      expect{card.touch_out(station)}.to change{card.balance}.by(-Oystercard::MINIMUM_CHARGE)
    end

    it "sets entry_station ivar to nil when touching out" do
      card.touch_out(station)
      expect(card.entry_station).to eq nil
    end

    it "stores exit_station" do
      card.touch_out(station2)
      expect(card.exit_station).to eq(station2)
    end

    it "should add the entire journey into the array" do
      card.touch_out(station2)
      expect(card.journeys).to include({:entry_station => station, :exit_station => station2})
    end
  end
end
