require_relative 'journey'

class JourneyLog


  def initialize(journey_class: Journey)
    @journey_class = journey_class
  end

  def start(entry_station)
    @journey_class.new(entry_station)
  end




end
