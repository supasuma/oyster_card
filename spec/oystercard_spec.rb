
require 'oystercard.rb'

describe Oystercard do

  it 'checks defult balance of Oystercard is 0' do
    expect(subject.balance).to eq 0
  end

  describe '#top_up' do

    it 'adds money to my oyster card' do
      expect{ subject.top_up 1 }.to change{ subject.balance }.by 1
    end

    it 'will not allow a balance to exceed 90' do
      max_balance = Oystercard::BALANCE_LIMIT
      subject.top_up(max_balance)
      expect{ subject.top_up 1 }.to raise_error "Your top up will exceed balance limit of #{max_balance}!"
    end

describe '#deduct' do
  it 'deducts fair from oystercard' do
    subject.top_up(1)
    expect {subject.deduct 1}.to change {subject.balance}.by -1
  end
end

  end

end
