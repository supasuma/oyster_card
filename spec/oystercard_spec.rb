require 'oystercard'

describe Oystercard do

  subject(:card) {described_class.new}
  subject(:other_card) {described_class.new}

  before(:each) do
    card.top_up(10)
  end

  describe "initialize" do
    it "creates an instance of the card and the balance should be zero" do
      expect(other_card.balance).to eq 0
    end

    it "creates an in_journey instance variable with default of false" do
      expect(card.in_journey).to eq false
    end

  end

  describe "#top_up" do
    it "responds to a method call with 1 argument" do
      expect(card).to respond_to(:top_up).with(1).arguments
    end

    it "adds an amount to the balance" do
      other_card.top_up(10)
      expect(card.balance).to eq 10
    end

    it "raises an error when more than the max amount is topped up" do
      top_up_amount = Oystercard::MAXIMUM_BALANCE+1
      expect{card.top_up(top_up_amount)}.to raise_error(RuntimeError)
    end
  end

  describe "#deduct" do
    it "responds to a method call with 1 argument" do
      expect(card).to respond_to(:deduct).with(1).arguments
    end

    it "deducts an amount from the balance" do
      card.top_up(20)
      expect{card.deduct(10)}.to change(card, :balance).from(30).to(20)
    end
  end

  describe "#in_journey?" do
    it "responds to method call" do
      expect(card).to respond_to :in_journey?
    end

    it "returns false if we call it after instantiated the instance" do
      expect(card.in_journey?).to eq false
    end
  end

  describe "#touch_in" do

    it "responds to method call" do
      expect(card).to respond_to :touch_in
    end

    it "change the in_journey instance variable to true " do
      card.touch_in
      expect(card).to be_in_journey
    end

    it "raises an error when user tries to touch in when already in_journey" do
      card.touch_in
      expect{ card.touch_in }.to raise_error(RuntimeError)
    end

    it "raises an error when try to touch in with balance less than £1" do
      amount_to_be_dedcuted = card.balance - Oystercard::MINIMUM_BALANCE + 0.1
      card.deduct(amount_to_be_dedcuted)
      expect{card.touch_in}.to raise_error(RuntimeError)
    end
  end

  describe "#touch_out" do
    it "responds to method call" do
      expect(card).to respond_to :touch_out
    end

    it "changes the in_journey ivar to false" do
      card.touch_in
      card.touch_out
      expect(card).not_to be_in_journey
    end

    it "raises an error when user tries to touch out when not in journey" do
      card.touch_in
      card.touch_out
      expect{ card.touch_out }.to raise_error(RuntimeError)
    end
  end
end
