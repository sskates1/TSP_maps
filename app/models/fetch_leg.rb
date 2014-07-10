
class FetchLeg
  def initialize(location1, location2, mode)
    location1_string = ''
    location1.attributes.each do |attribute|
      location1_string += attribute
    end
    location2_string = ''
    location2.attributes.each do |attribute|
      location2_string += attribute
    end
    @location1 = location1_string
    @location2 = location2_string
    @mode = mode
  end

  def fetch
    leg = GoogleMaps.new(@location1, @location2, @mode)
    leg
  end
end
