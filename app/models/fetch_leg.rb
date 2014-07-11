
class FetchLeg
  def initialize(location1, location2, mode)
    location1_string = ''
    location1.attributes.each do |attr_name, attr_value|
      if attr_name != 'created_at' &&
         attr_name != 'updated_at' &&
         attr_name != 'id'
        location1_string += ' '
        location1_string += attr_value
      end
    end
    location2_string = ''
    location2.attributes.each do |attr_name, attr_value|
      if attr_name != 'created_at' &&
        attr_name != 'updated_at' &&
        attr_name != 'id'
        location2_string += ' '
        location2_string += attr_value
      end
    end
    @location1 = location1_string
    @location2 = location2_string
    @mode = mode
  end

  def fetch
    leg = GoogleMaps.new(@location1, @location2, @mode)
    leg = leg.directions
    leg
  end
end
