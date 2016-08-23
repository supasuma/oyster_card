require_relative "journey.rb"
require_relative "station.rb"

class Oystercard
  MAXIMUM_BALANCE = 90
  MINIMUM_BALANCE = 1
  MINIMUM_CHARGE = 1


  attr_reader :balance, :entry_station, :exit_station, :journeys

  def initialize
   @balance = 0
   @journeys = []
   @journey = nil
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
    still_in_journey = in_journey?
    @entry_station = station
    @journey = Journey.new(station, nil)
    store_journey
    deduct(@journey.fare) if still_in_journey
  end

  def touch_out(station)
    if @journey.nil?
      @journey = Journey.new(nil, station)
      store_journey
    else
      @journeys[-1].finish(station)
    end
    deduct(@journey.fare)
    @entry_station = nil
    @journey = nil
  end

  private
  def below_limit?
    balance < MINIMUM_BALANCE
  end

  def deduct(amount)
    @balance -= amount
  end

  def store_journey
    @journeys << @journey
  end
end
