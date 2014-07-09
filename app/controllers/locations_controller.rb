class LocationsController < ApplicationController
  respond_to :html, :json
  def create
    @trip = Trip.find(params[:trip_id])
    @location = @location.new(location_params)

    if @location.save
      flash[:notice] = 'Your locattion was added!'
      redirect_to @trip
    else
      flash[:notice] = 'Your location could not be added'
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
