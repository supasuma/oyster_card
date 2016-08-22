require 'Oystercard.rb'

describe Oystercard do
  it 'checks defult balance of Oystercard is 0' do
    expect(subject.balance).to eq 0
  end
end
