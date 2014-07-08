class CreateLegs < ActiveRecord::Migration
  def change
    create_table :legs do |t|
      t.integer :start_location_id, null: false
      t.integer :end_location_id, null: false
      t.integer :distance
      t.string :distance_unit

      t.timestamps
    end
  end
end
