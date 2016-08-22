class Oystercard

  attr_reader :balance, :max_balance

  DEFAULT_MAX = 90

  def initialize(balance = 0, max_balance = DEFAULT_MAX)
    @balance = balance
    @max_balance = max_balance
  end

  def top_up(amount)
    fail "balance cannot exceed #{@max_balance}" if amount > max_balance - balance
    @balance += amount
  end

end
