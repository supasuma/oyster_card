require 'oystercard'

describe Oystercard do

  subject(:card) {described_class.new}

  describe "initialize" do
    it "creates an instance of the card and the balance should be zero" do
      expect(card.balance).to eq 0
    end
  end

  describe "#top_up" do
    it "responds to a method call with 1 argument" do
      expect(card).to respond_to(:top_up).with(1).arguments
    end

    it "adds an amount to the balance" do
      card.top_up(10)
      expect(card.balance).to eq 10
    end

    it "raises an error when more than the max amount is topped up" do
      top_up_amount = Oystercard::MAXIMUM_BALANCE+1
      expect{card.top_up(top_up_amount)}.to raise_error(RuntimeError)
    end


  end
end
