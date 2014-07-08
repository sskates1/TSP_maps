class CreateTripLegs < ActiveRecord::Migration
  def change
    create_table :trip_legs do |t|
      t.integer :time
      t.integer :leg_id, null: false
      t.integer :trip_id, null: false
      t.integer :order_position
      t.timestamps
    end
  end
end
