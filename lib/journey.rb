class Journey

  attr_reader :entry_station

  def initialize(entry_station)
    @entry_station = entry_station
  end

  def finish_journey(exit_station)
    {:entry_station => @entry_station , :exit_station => exit_station}
  end

  # def exit_station(exit_station)
  #   @exit_station = exit_station
  # end
  #
  # def finish_journey(exit_station)
  #   journeys << { entry_station: entry_station, exit_station: exit_station }
  # end
  #
  # def is_journey_complete?
  #
  # end

end
