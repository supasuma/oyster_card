class Journey

attr_reader :entry_station, :exit_station

  MIN_FARE = 1
  PEN_FARE = 6

  def initialize(entry_station, exit_station)
    @entry_station = entry_station
    @exit_station = exit_station
  end

  def finish(station)
    @exit_station = station
    self
  end

  def complete?
    !!@entry_station && !!@exit_station
  end

  def fare
    if complete?
      MIN_FARE
    else
      PEN_FARE
    end
  end

end
