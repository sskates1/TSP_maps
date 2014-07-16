class AddColumnToTripLegs < ActiveRecord::Migration
  def change
    add_column :legs, :text_distance, :string
    add_column :trip_legs, :text_time, :string
  end
end
