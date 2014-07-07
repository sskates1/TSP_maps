class CreateTrips < ActiveRecord::Migration
  def change
    create_table :trips do |t|
      t.string :name, null: false
      t.integer :distance
      t.integer :time
      t.string :distance_unit
      t.integer :user_id, null: false
      t.string :mode, default: 'car'

      t.timestamps
    end
  end
end
