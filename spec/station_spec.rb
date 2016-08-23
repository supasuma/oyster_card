require 'station'

describe Station do
  let(:station) {described_class.new("Canada Water", 2)}

  describe "name" do
    it "returns the value of name instance variable" do
      expect(station.name).to eq "Canada Water"
    end
  end

  describe "zone" do
    it "returns the value of zone instance variable" do
      expect(station.zone).to eq 2
    end
  end
end
