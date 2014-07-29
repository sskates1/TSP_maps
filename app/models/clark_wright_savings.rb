class ClarkWrightSavings
  attr_accessor :previous_locations
  def initialize(trip)
    @trip = trip
    @previous_locations = []
    @tour_primative = []
    @savings_list = []
    @start_location = @trip.all_locations[0]
    @end_point_1 = Location.new
    @end_point_2 = Location.new
  end

  def get_route_distance

  end

  def update_savings_list
    @savings_list = []
    @trip.trip_legs.each do |trip_leg1|

      new_location = nil
      connection_trip_leg = nil
      return_trip_leg = nil
      saved_trip_leg = nil

      # finds connection leg to one of the end points
      if trip_leg1.leg.start_location == @end_point_1 ||
        trip_leg1.leg.start_location == @end_point_2 &&
        !trip_leg1.leg.end_location.nil?

        new_location = trip_leg1.leg.end_location
        connection_trip_leg = trip_leg1

      elsif trip_leg1.leg.end_location == @end_point_1 ||
        trip_leg1.leg.end_location == @end_point_2

        new_location = trip_leg1.leg.start_location
        connection_trip_leg = trip_leg1

      else
        next
      end

      @trip.trip_legs.each do |trip_leg2|
        # look only at the legs going to the start location to
        # the new location and the end point
        if trip_leg2.leg.start_location == @start_location &&
          trip_leg2.leg.end_location == new_location

          return_trip_leg = trip_leg2

        elsif trip_leg2.leg.end_location == @start_location &&
          trip_leg2.leg.end_location == new_location

          return_trip_leg = trip_leg2

        elsif trip_leg2.leg.start_location == @start_location &&
          trip_leg2.leg.end_location == @end_point_1

          saved_trip_leg = trip_leg2

        elsif trip_leg2.leg.end_location == @start_location &&
          trip_leg2.leg.end_location == @end_point_1

          saved_trip_leg = trip_leg2

        else
          next
        end
      end
      if !new_location.nil? && !connection_trip_leg.nil? &&
        !return_leg.nil? && !saved_leg.nil?
        @savings_list << {
          new_location: new_location,
          connection_trip_leg: connection_trip_leg,
          return_trip_leg: return_trip_leg,
          saved_trip_leg: saved_trip_leg
        }
      end
    end
    # end trip_legs1 .each
  end
  # end update_savings_list

  def create_tour_primative
    location1 = Location.new
    location2 = Location.new
    @trip.trip_legs.each do |trip_leg1|
      if trip_leg1.leg.start_location == @start_location &&
        !trip_leg1.leg.end_location.nil?

        location1 = trip_leg1.leg.end_location

      elsif trip_leg1.leg.end_location == @start_location

        location1 = trip_leg1.leg.start_location
      else
        next
      end

      @trip.trip_legs.each do |trip_leg2|

        # look only at the legs going to the start location
        if trip_leg2.leg.start_location == @start_location &&
          !trip_leg2.leg.end_location.nil?

          location2 = trip_leg2.leg.end_location

        elsif trip_leg2.leg.end_location == @start_location

          location2 = trip_leg2.leg.start_location
        else
          next
        end
        @trip.trip_legs.each do |connection_leg|
          if (connection_leg.leg.start_location == location1 &&
            connection_leg.leg.end_location == location2) ||
            (connection_leg.leg.start_location == location2 &&
              connection_leg.leg.end_location == location1)

            @savings_list << { location1: location1,
                              location2: location2,
                              trip_leg1: trip_leg1,
                              trip_leg2: trip_leg2,
                              connection: connection_leg }

            break
            # end loop once found the right connection
          end
          # end if connection leg
        end
        # end .each connection leg
      end
      # end .each trip_leg2
    end
    # end .each trip_leg1
    if @savings_list.length > 0
      initial_tour_primative = @savings_list.max_by do |savings|
        savings[:trip_leg1].time + savings[:trip_leg2].time - savings[:connection].time
      end
      @end_point_1 = initial_tour_primative[:location1]
      @end_point_2 = initial_tour_primative[:location2]
      @tour_primative.push( initial_tour_primative[:trip_leg1],
                            initial_tour_primative[:connection],
                            initial_tour_primative[:trip_leg2] )
      @previous_locations.push(@start_location,@end_point_1, @end_point_2)
    end
  end
  # end create_tour_primative

  def tour_endpoints
    #savings should be created relative to the tour endpoints
    #update endpoints
  end

  def get_route
    create_tour_primative
    while @previous_locations.length < @trip.all_locations.length
      update_savings_list
      max_savings_legs = @savings_list.max_by do |legs_to_add|
        legs_to_add[:saved_trip_leg] + legs_to_add[:return_trip_leg] - legs_to_add[:connection_trip_leg]
      end
      @tour_primative << max_savings_legs
      @previous_locations << max_savings_legs[:new_location]
    end
  end
end


# 1. Select base point {b}
# 2. Construct a tour primitive by finding the two points with the largest savings shortcut
# 3. While not all points have been added to the partial tour
# 4. Update the computation of the savings of combining tours
# 5. Append point with largest savings shortcut to endpoints of the partial tour
