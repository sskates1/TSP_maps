class TripLeg < ActiveRecord::Base
  belongs_to :trip
  belongs_to :leg

  validates :leg,
    presence: true,
    uniqueness: { scope: :trip }
end
