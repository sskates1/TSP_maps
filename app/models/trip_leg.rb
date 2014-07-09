class TripLeg < ActiveRecord::Base
  belongs_to :trip
  belongs_to :leg
end
