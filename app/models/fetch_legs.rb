
class FetchLegs
  def initialize(location1, location2, mode)
    @location1 = location1
    @location2 = location2
    @mode = mode
  end

  def fetch
    leg = GoogleMaps.new(@location1, @location2, @mode)
    leg
  end
end
