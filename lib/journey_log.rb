require_relative 'journey'

class JourneyLog

  attr_reader :journey_history, :entry_station, :exit_station

  def initialize(journey_class: Journey)
    @journey_class = journey_class
    @journey = nil
    @journey_history = []
  end

  def start_journey(start_station)
    @start_station = start_station
    @journey = current_journey(start_station)
  end

  def finish_journey(end_station)
    @end_station = end_station
    @journey.finish(end_station)
    @journey_history << @journey

    @journey = nil

    # @journey_history << {:entry_station => @entry_station , :exit_station => exit_station}
  end

private

attr_reader :current_journey

 def current_journey(station)
   if @journey.nil?
     @journey_class.new(station)
   else
     @journey_history << @journey
   end
 end

end
