class Oystercard

  attr_reader :balance, :max_balance, :entry_station, :exit_station, :journey_log

  DEFAULT_MAX = 90
  MIN_BALANCE = 1

  def initialize(balance = 0, max_balance = DEFAULT_MAX)
    @balance = balance
    @max_balance = max_balance
    @journey_log = []
  end

  def top_up(amount)
    fail "balance cannot exceed £#{@max_balance}" if amount > max_balance - balance
    @balance += amount
  end

  def in_journey?
    !!@entry_station
  end

  def touch_in(station)
    fail "balance less than £#{MIN_BALANCE} - please top up" if balance < MIN_BALANCE
    @entry_station = station
    @journey_log << {:entry_station => station}
  end

  def touch_out(station)
    deduct(MIN_BALANCE)
    @exit_station = station
    @journey_log[-1][:exit_station] = station
    @entry_station = nil
  end

  private

  def deduct(amount)
    @balance -= amount
  end

end
