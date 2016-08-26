#Creates the current journey and assigns corresponding fare.

class Journey

  attr_reader :entry_station, :exit_station

  MINIMUM_FARE = 1
  PENALTY_FARE = 6

  def initialize(entry_station = nil)
    @entry_station = entry_station
    @exit_station = nil
  end

  def finish(exit_station = @exit_station)
    @exit_station = exit_station
    self #= {:entry_station => @entry_station , :exit_station => exit_station}
  end

  def fare
    complete? ? MINIMUM_FARE : PENALTY_FARE
  end

  private

  def complete?
    !!@exit_station && !!@entry_station
  end

end
