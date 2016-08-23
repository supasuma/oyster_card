class Oystercard

  attr_reader :balance, :max_balance, :entry_station, :exit_station

  DEFAULT_MAX = 90
  MIN_BALANCE = 1

  def initialize(balance = 0, max_balance = DEFAULT_MAX)
    @balance = balance
    @max_balance = max_balance
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
  end

  def touch_out(station)
    deduct(MIN_BALANCE)
    @entry_station = nil
    @exit_station = station
  end

  private

  def deduct(amount)
    @balance -= amount
  end

end
