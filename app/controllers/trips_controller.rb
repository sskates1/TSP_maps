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

  def update
    @trip = Trip.find(params[:id])

    if params[:update_route]
      @nearest_neighbor = NearestNeighbor.new(@trip)
      @trip.route = @nearest_neighbor.get_route
      #binding.pry
      @trip.save
    end
    #binding.pry
    if @trip.update(name: params[:name], mode: params[:mode])
      redirect_to @trip
    elsif params[:update_route]
      flash[:notice] = "Route calculated!"
      redirect_to @trip
    else
      flash[:alert] = "Could not update your trip."
      redirect_to :back
    end
  end

  private

  def trip_params
    params.require(:trip).permit(:name, :mode)
  end
end
