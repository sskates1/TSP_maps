class Trip < ActiveRecord::Base
  belongs_to :user

  has_many :trip_legs
  has_many :legs, through: :trip_legs

  validates :name, presence: true
  validates :user, presence: true

  def all_locations
    locations = []
    legs.each do |leg|
      locations << leg.all_locations
    end
    locations.flatten.uniq
  end
end
