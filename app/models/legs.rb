class Legs < ActiveRecord::Base
  belongs_to :start_location, class_name: 'Location'
  belongs_to :stop_location, class_name: 'Location'

  has_many :trip_legs

  validates :distance, presence: true
  validates :unit, presence: true
end
