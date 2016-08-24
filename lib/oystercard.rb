require_relative 'journey'
require_relative 'station'

class Oystercard

  attr_reader :balance, :max_balance, :entry_station, :journey_log

  DEFAULT_MAX = 90
  MIN_BALANCE = 1

  def initialize(balance = 0, max_balance = DEFAULT_MAX)
    @balance = balance
    @max_balance = max_balance
    @journey_log = []
    @journey = nil
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
    @journey = Journey.new(station, nil)
    @entry_station = station
    @journey_log << @journey
  end

  def touch_out(station)
    @journey_log[-1].finish(station)
    amount = @journey.fare
    deduct(amount)
    @entry_station = nil
  end

  private

  def deduct(amount)
    @balance -= amount
  end

end
