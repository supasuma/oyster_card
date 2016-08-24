require_relative 'journey'

#Maintains a balance through touch in & touch out. Also records journey history, soon to be pulled out.

class Oystercard

MAXIMUM_LIMIT = 90
MINIMUM_LIMIT = 1

attr_reader :balance , :journey, :journeys

  def initialize
    @balance = 0
    @journey = nil
    @journeys = []
  end

  def top_up(amount)
    fail 'Top up limited exceeded' if amount + balance > MAXIMUM_LIMIT
    @balance += amount
  end

  def touch_in(entry_station)
    fail "Insufficient funds. Please top up." if balance < MINIMUM_LIMIT
    check(entry_station)
  end

  def touch_out(exit_station)
    @journey = Journey.new if @journey == nil
    record_journey(exit_station)
    @journey = nil
  end

  private

  def deduct(amount)
    @balance -= amount
  end

  def check(entry_station)
    if @journey == nil
      @journey = Journey.new(entry_station)
    else
      journeys << @journey.finish_journey(nil)
      finish
    end
  end

  def record_journey(exit_station)
    journeys << @journey.finish_journey(exit_station)
    finish
  end

  def finish
    deduct(@journey.fare)
  end
end
