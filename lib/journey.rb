class Journey

attr_reader :entry_station, :exit_station

  MIN_FARE = 1

  def initialize(entry_station)
    @entry_station = entry_station

  end

  def finish(station)
    @exit_station = station
  end

  def fare
    MIN_FARE
  end

end
