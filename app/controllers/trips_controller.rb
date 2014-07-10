class TripsController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]
  def index
    @trips = Trip.all
  end

  def show
    @trip = Trip.find(params[:id])
    binding.pry
    @location = Location.new
    @leg = Leg.new
  end

  def new
    @trip = Trip.new
  end

  def create
    @trip = current_user.trips.build(trip_params)

    if @trip.save
      flash[:notice] = 'Success!'
      redirect_to '/trips'
    else
      flash.now[:notice] = "Your trip couldn't be saved."
      render :new
    end
  end

  def compute_route

  end

  private

  def trip_params
    params.require(:trip).permit(:name, :mode)
  end
end
