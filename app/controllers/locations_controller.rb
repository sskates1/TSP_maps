class LocationsController < ApplicationController
  respond_to :html, :json
  def create
    @trip = Trip.find(params[:trip_id])
    @location = @trip.new(location_params)

    if @location.save
      flash[:notice] = 'Your review was saved!'
      redirect_to locations_new_path(@trip)
    else
      flash[:notice] = 'Your location could not be saved'
      render @trip
    end
  end

  def new
    @location = Location.new
  end


  private

  def location_params
    params.require(:review).permit(:address, :city, :state, :country, :area_code)
  end
end
