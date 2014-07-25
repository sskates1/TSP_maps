class NearestNeighbor
  attr_accessor :previous_locations
  def initialize(trip)
    @trip = trip
    @previous_locations = []
    @tour_primative = []
    @savings_list = []
  end

  def get_basic_route
    @start_location = @trip.all_locations[0]
    trip_legs = @trip.trip_legs

    trip_legs.each do |trip_leg|
      if (trip_leg.leg.start_location == start_location ||
        trip_leg.leg.end_location == start_location) &&
        !trip_leg.leg.end_location.nil?

        legs_times << trip_leg

        end
      end
    end
  end

  def get_route_distance

  end

  def update_savings_list

  end

  def create_tour_primative

  end

  def tour_endpoints
    #savings should be created relative to the tour endpoints
  end

  def get_route
    get_basic_route
    @start_location
    create_tour_primative
    while @previous_locations.length < @trip.all_locations.length
      update_savings_list
      max_savings_legs = @savings_list.min_by do |legs_to_add|
        legs_to_add.savings
      end
      @tour_primative << max_savings_legs
      @previous_locations << max_savings_legs.added_location
    end
  end
end


# 1. Select base point {b}
# 2. Construct a tour primitive by finding the two points with the largest savings shortcut
# 3. While not all points have been added to the partial tour
# 4. Update the computation of the savings of combining tours
# 5. Append point with largest savings shortcut to endpoints of the partial tour
