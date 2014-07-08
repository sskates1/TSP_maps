class Legs < ActiveRecord::Base
  belongs_to :start_location, class_name: 'Location', foreign_key: 'location_id'
  belongs_to :stop_location, class_name: 'Location', foreign_key: 'location_id'

  has_many :trip_legs

  validates :distance, presence: true
  validates :unit, presence: true
end
