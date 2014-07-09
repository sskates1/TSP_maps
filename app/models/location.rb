class Location < ActiveRecord::Base
  has_many :legs, as: :start_location
  has_many :legs, as: :end_location
end
