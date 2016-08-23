class Oystercard

MAXIMUM_LIMIT = 90
MINIMUM_LIMIT = 1

attr_reader :balance , :entry_station

  def initialize
    @balance = 0
    @in_journey = false
  end

  def top_up(amount)
    fail 'Top up limited exceeded' if amount + balance > MAXIMUM_LIMIT
    @balance += amount
  end

  def in_journey?
    !!@entry_station
  end

  def touch_in(entry_station)
    fail "Insufficient funds. Please top up." if balance < MINIMUM_LIMIT
    @entry_station = entry_station
  end

  def touch_out
    deduct(MINIMUM_LIMIT)
    @entry_station = nil
  end

  private

  def deduct(amount)
    @balance -= amount
  end

end
