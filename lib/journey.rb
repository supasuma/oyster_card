class Journey

attr_reader :entry_station, :exit_station, :current_journey

  MIN_FARE = 1
  PEN_FARE = 6

  def initialize(station)
    @entry_station = station[:entry_station]
    @current_journey = {}
  end

  def finish(station)
    @exit_station = station
  end

  def complete?
    !!@entry_station && !!@exit_station
  end

  def fare
    if complete? == true
      MIN_FARE
    else
      PEN_FARE
    end
  end

end
