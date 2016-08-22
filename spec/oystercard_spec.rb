require 'oystercard'

describe Oystercard do

  subject(:card) {described_class.new}

  describe "initialize" do
    it "creates an instance of the card and the balance should be zero" do
      expect(card.balance).to eq 0
    end
  end

end
