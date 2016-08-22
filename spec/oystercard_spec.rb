require 'oystercard'

describe Oystercard do

  subject(:oyster) { described_class.new }

  it 'initializes with a balance of 0' do
    expect(oyster.balance).to eq(0)
  end

end
