class Oystercard

MAXIMUM_LIMIT = 90
MINIMUM_LIMIT = 1

attr_reader :balance

  def initialize
    @balance = 0
    @in_journey = false
  end

  def top_up(amount)
    fail 'Top up limited exceeded' if amount + balance > MAXIMUM_LIMIT
    @balance += amount
  end

  def in_journey?
    @in_journey
  end

  def touch_in
    fail "Insufficient funds. Please top up." if balance < MINIMUM_LIMIT
    @in_journey = true
  end

  def touch_out
    @in_journey = false
    deduct(MINIMUM_LIMIT)
  end

  private

  def deduct(amount)
    @balance -= amount
  end

end
