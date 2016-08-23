class Oystercard

MAXIMUM_LIMIT = 90
MINIMUM_LIMIT = 1

attr_reader :balance , :entry_station, :exit_station, :journeys

  def initialize
    @balance = 0
    @in_journey = false
    @journeys = []
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

  def touch_out(exit_station)
    deduct(MINIMUM_LIMIT)
    @exit_station = exit_station
    journeys << { entry_station: entry_station, exit_station: exit_station }

    @entry_station = nil
  end

  private

  def deduct(amount)
    @balance -= amount
  end

end
