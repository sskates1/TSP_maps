class TripsController < ApplicationController
  def index
    @trips = Trip.all
  end

  def show
    @trip = Trip.find(params[:id])
    @location = Character.new
  end

  def new
    @trip = Trip.new
  end

  def create
    @television_show = TelevisionShow.new(television_show_params)

    if @television_show.save
      flash[:notice] = "Success!"
      redirect_to '/television_shows'
    else
      flash.now[:notice] = "Your movie couldn't be saved."
      render :new
    end
  end

  def compute_route

  end

end
