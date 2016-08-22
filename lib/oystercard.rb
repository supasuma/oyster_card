class Oystercard

MAXIMUM_LIMIT = 90

attr_reader :balance

  def initialize
    @balance = 0
  end

  def top_up(amount)
    fail 'Top up limited exceeded' if amount + balance > MAXIMUM_LIMIT
    @balance = amount
  end
end
