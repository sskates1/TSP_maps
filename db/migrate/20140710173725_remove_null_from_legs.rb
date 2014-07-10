class RemoveNullFromLegs < ActiveRecord::Migration
  def up
    change_column :legs, :end_location_id, :integer, null: true
  end
  def down
    change_column :legs, :end_location_id, :integer, null: true  
  end
end
