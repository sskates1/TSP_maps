class NearestNeighbor
  attr_accessor :previous_locations
  def initialize(trip)
    @trip = trip
    @previous_locations = []
  end

  def get_route
    start_location = @trip.all_locations[0]
    locations = @trip.all_locations
    locations.shift
    trip_legs = @trip.trip_legs
    current_location = start_location
    count = 1

    trip_legs.each do |trip_leg|
      trip_leg.order_position = nil
      trip_leg.save
    end

    while locations.length > 0
      legs = []
      legs_times = []
      return_home_trip_leg = TripLeg.new
      trip_legs.each do |trip_leg|
        if (trip_leg.leg.start_location == current_location ||
          trip_leg.leg.end_location == current_location) &&
          !trip_leg.leg.end_location.nil?

          legs_times << trip_leg

          if (trip_leg.leg.start_location == start_location ||
            trip_leg.leg.end_location == start_location)

            return_home_trip_leg = trip_leg
          end
        end
      end

      # legs = current_location.legs
      temp_legs = legs_times.clone
      legs_times.each do |trip_leg|
        if @previous_locations.include?(trip_leg.leg.start_location) ||
          @previous_locations.include?(trip_leg.leg.end_location)

          temp_legs.delete(trip_leg)
        end
      end
      legs_times = temp_legs

      shortest_leg = legs_times.min_by do |legs_time|
        legs_time.time
      end

      if legs_times.empty?
        shortest_leg = return_home_trip_leg
      end
      shortest_leg = shortest_leg.leg

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

      @previous_locations << current_location
      current_location = new_location
      # end while
    end
    return @previous_locations
  end
end
