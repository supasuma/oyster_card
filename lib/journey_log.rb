require_relative 'journey'

class JourneyLog



  def initialize(journey_class: Journey)
    @journey_class = journey_class
    @journey = nil

  end

  def start(entry_station)
    @entry_station = entry_station
    @journey = current_journey(entry_station)
  end

  def finish(exit_station)
    @exit_station = exit_station
    @journey = {:entry_station => @entry_station , :exit_station => exit_station}
  end

private

attr_reader :current_journey

 def current_journey(entry_station)
   if @journey.nil?
     @journey_class.new(entry_station)
   else
    @journey
   end
 end

end
