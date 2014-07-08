class CreateTrips < ActiveRecord::Migration
  def change
    create_table :trips do |t|
      t.string :name, null: false
      t.integer :user_id, null: false
      t.string :mode, default: 'car'

      t.timestamps
    end
  end
end
