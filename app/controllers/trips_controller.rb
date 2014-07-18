class TripsController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]
  def index
    if user_signed_in?
      @trips = current_user.trips
    else
      flash[:warning] = "Please login to view your trips."
      @trips = []
    end
  end

  def show
    @trip = Trip.find(params[:id])
    @location = Location.new
  end

  def new
    @trip = Trip.new
  end

  def create
    @trip = current_user.trips.new(trip_params)

    if @trip.save
      flash[:notice] = "Success!"
      redirect_to @trip
    else
      render :new
    end
  end

  def compute_route
    @trip = Trip.find(params[:id])
    @nearest_neighbor = NearestNeighbor.new(@trip)
    @nearest_neighbor.get_route
    redirect_to @trip
  end

  private

  def trip_params
    params.require(:trip).permit(:name, :mode)
  end
end
