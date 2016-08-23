require_relative 'station.rb'

class Oystercard

  attr_reader :balance, :entry_station, :exit_station
  attr_accessor :in_journey
  alias :in_journey? :in_journey

  BALANCE_LIMIT = 90
  MIN_FARE = 1

  def initialize
    @balance = 0
    @in_journey = false
    @entry_station = nil
    @exit_station = nil
    #@journey_history = [@entry_station: @exit_station]
  end

  def touch_in(station)
    fail 'you have insufficient funds on your oystercard' if balance < MIN_FARE
    @exit_station = nil
    @entry_station = station
    in_journey?
  end

  def touch_out(station)
    deduct(MIN_FARE)
    @exit_station = station
    @entry_station = nil
    in_journey?
  end

  def in_journey?
    !!entry_station
  end

  def top_up(value)
    fail "Your top up will exceed balance limit of #{BALANCE_LIMIT}!" if value + balance > BALANCE_LIMIT
    @balance += value
  end


private

  def deduct(fare)
    @balance -= fare
  end



end
