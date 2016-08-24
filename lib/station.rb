#Assigns station for log in/out. Currently not in full use.

class Station

attr_reader :name, :zone

  def initialize(name: name, zone: zone)
    @name = name
    @zone = zone
  end
end
