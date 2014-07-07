class CreateLegs < ActiveRecord::Migration
  def change
    create_table :legs do |t|
      t.integer :start_location_id, null: false
      t.integer :end_location_id, null: false
      t.integer :trip_id, null: false
      t.integer :distance
      t.integer :time
      t.string :distance_unit
      t.mode :mode

      t.timestamps
    end
  end
end
