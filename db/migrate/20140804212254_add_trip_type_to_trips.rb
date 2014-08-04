class AddTripTypeToTrips < ActiveRecord::Migration
  def change
    add_column :trips, :type, :string
  end
end
