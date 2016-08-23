class Oystercard
  MAXIMUM_BALANCE = 90
  MINIMUM_BALANCE = 1
  MINIMUM_CHARGE = 1

  attr_reader :balance, :entry_station, :exit_station, :journeys

  def initialize
   @balance = 0
   @journeys = []
  end

  def top_up(amount)
    fail "Can't add more than £#{MAXIMUM_BALANCE}" if balance + amount >  MAXIMUM_BALANCE
    @balance += amount
  end

  def in_journey?
    !!@entry_station
  end

  def touch_in(station)
    fail "Your balance is less than £1" if below_limit?
    @in_journey = true
    @entry_station = station
  end

  def touch_out(station)
    @in_journey = false
    deduct(MINIMUM_CHARGE)
    @exit_station = station
    store_journey
    @entry_station = nil
  end

  private
  def below_limit?
    balance < MINIMUM_BALANCE
  end

  def deduct(amount)
    @balance -= amount
  end

  def store_journey
    @journeys << {entry_station: entry_station, exit_station: exit_station}
  end
end
