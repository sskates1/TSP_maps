module LocationsHelper
  def creator?(trip)
    if trip.user != current_user
      flash[:notice] = "This is not your trip!"
      return redirect_to trip_path(trip)
    end
  end
end
