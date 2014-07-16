class Leg < ActiveRecord::Base
  belongs_to :start_location, class_name: "Location"
  belongs_to :end_location, class_name: "Location"

  has_many :trip_legs
  has_many :trips, through: :trip_legs

  validates :distance, presence: true
  validates :distance_unit, presence: true

  validates :start_location,
            presence: true,
            uniqueness: { scope: :end_location }

  def all_locations
    locations = []
    locations << start_location
    if !end_location.nil?
      locations << end_location
    end
    locations
  end
end
