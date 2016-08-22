require 'oystercard'

describe Oystercard do
  it 'Describes an account when it is first opened' do
    expect(subject.balance).to eq (0)
  end
end
