class Trips < ActiveRecord::Base
  belongs_to user
  has_many legs
end
