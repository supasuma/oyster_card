class Journey

  attr_reader :entry_station

  MINIMUM_FARE = 1
  PENALTY_FARE = 6

  def initialize(entry_station = nil)
    @entry_station = entry_station
    @exit_station = nil
  end

  def finish_journey(exit_station = @exit_station)
    @exit_station = exit_station
    @journey = {:entry_station => @entry_station , :exit_station => exit_station}
  end

  def fare
    #PENALTY_FARE unless @entry_station == nil
    if @exit_station == nil || @entry_station == nil
      PENALTY_FARE
    else
      MINIMUM_FARE
    end
  end

  #How do we create an instance where there is no touch in???


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
