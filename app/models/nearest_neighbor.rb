class NearestNeighbor
  def initialize(trip)
    @trip = trip
  end

  def get_route
    start_location = @trip.all_locations[0]
    locations = @trip.all_locations
    locations.shift
    trip_legs = @trip.trip_legs
    current_location = start_location
    previous_locations = [ ]
    count = 1

    while locations.length > 0
      legs = []
      return_home_leg = TripLeg.new
      trip_legs.each do |trip_leg|
        if (trip_leg.leg.start_location == current_location ||
          trip_leg.leg.end_location == current_location) &&
          !trip_leg.leg.end_location.nil?

          legs << trip_leg.leg

          if (trip_leg.leg.start_location == start_location ||
            trip_leg.leg.end_location == start_location)
            return_home_leg = trip_leg.leg
          end
        end
      end

      # legs = current_location.legs
      temp_legs = legs.clone
      legs.each do |leg|
        if previous_locations.include?(leg.start_location) ||
          previous_locations.include?(leg.end_location)

          temp_legs.delete(leg)
        end
      end
      legs = temp_legs

      shortest_leg = legs.min_by do |leg|
        leg.distance
      end
      if legs.empty?
        shortest_leg = return_home_leg
      end

      trip_legs.each do |trip_leg|
        if trip_leg.leg == shortest_leg
          trip_leg.order_position = count
          count += 1
          trip_leg.save
        end
      end

      if current_location == shortest_leg.start_location
        new_location = shortest_leg.end_location
      else
        new_location = shortest_leg.start_location
      end

      locations.delete_if do |location|
        location == current_location
      end

      previous_locations << current_location
      current_location = new_location
      # end while
    end
    previous_locations
  end
end
