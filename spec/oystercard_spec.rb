require 'oystercard'

describe Oystercard do
  it 'Describes an account when it is first opened' do
    expect(subject.balance).to eq (0)
  end

  describe '#top_up' do
    it 'tops up Oystercard by amount 20' do
      expect { subject.top_up(20) }.to change{subject.balance}.by(20)
    end

    it 'raises an error when top up limit is exceeded' do
      maximum_limit = Oystercard::MAXIMUM_LIMIT
      subject.top_up(maximum_limit)
      expect{ subject.top_up(1) }.to raise_error 'Top up limited exceeded'
    end
  end

  describe 'touch_in' do
    it 'returns true when card touched in' do
      subject.top_up(20)
      subject.touch_in
      expect(subject).to be_in_journey
    end

    it 'raises error if balance is less than minimum required' do
      msg = "Insufficient funds. Please top up."
      expect{ subject.touch_in }.to raise_error msg
    end
  end

  describe 'touch_out' do
    it 'returns true when card touched out' do
      subject.top_up(20)
      subject.touch_in
      subject.touch_out
      expect(subject).to_not be_in_journey
    end
    it 'deducts fare when touching out' do
      subject.top_up(20)
      subject.touch_in
      subject.touch_out
      expect { subject.touch_out}.to change { subject.balance }.by( -Oystercard::MINIMUM_LIMIT)
    end
  end

  describe 'in_journey' do
    it 'card initializes with not in journey' do
      expect(subject.in_journey?).to be false
    end
  end
end
