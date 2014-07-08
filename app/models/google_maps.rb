class GoogleMaps
  include HTTParty
  base_uri 'http://maps.googleapis.com/maps/api'

  def initialize(origin, destination, mode = 'driving')
    @options = { query: { origin: origin, destination: destination, mode: mode } }
  end

  def directions
    self.class.get('/directions/json', @options)
  end

end
