class AddColumnRouteToTrips < ActiveRecord::Migration
  def change
    add_column :trips, :route, :string, array: true, default: '{}'
  end
end
