class LocationsController < ApplicationController
  before_action :authenticate_user!, except: [:show]
  respond_to :html, :json
  def create
    @trip = Trip.find(params[:trip_id])
    @location = Location.create(location_params)
    if @trip.all_locations.count != 0
      @trip.all_locations.each do | location |
        fetch_leg = FetchLeg.new(@location, location, @trip.mode)
        leg_info = fetch_leg.fetch

        leg = Leg.new
        leg.start_location = @location
        leg.end_location = location

        leg.distance = leg_info['routes']['legs'][0]['distance']['value']
        leg.distance_unit = 'm'
        leg.save


        trip_leg = TripLeg.new
        trip_leg.trip = @trip
        trip_leg.leg = leg

        if trip_leg.save
          flash[:notice] = 'Success!'
          redirect_to @trip
        else
          flash.now[:notice] = "Your location couldn't be saved."
          redirect_to @trip
        end

      end
    else
      leg = Leg.new
      leg.start_location = @location
      leg.distance = 0
      leg.distance_unit = 'm'
      leg_saved = leg.save

      trip_leg = TripLeg.new
      trip_leg.trip = @trip
      trip_leg.leg = leg

      #binding.pry
      if trip_leg.save && leg_saved
        flash[:notice] = 'Success!'
        redirect_to @trip
      else
        flash.now[:notice] = "Your location couldn't be saved."
        redirect_to @trip
      end
    end

  end

  def new
    @location = Location.new
  end


  private

  def location_params
    params.require(:location).permit(:address, :city, :state, :country, :area_code)
  end
end