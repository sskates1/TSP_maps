class Trips < ActiveRecord::Base
  belongs_to :user
  
  has_many :trip_legs
  has_many :legs, through: :trip_legs
  has_many :locations, through: :trip_legs, through: :legs

  validates :name, presence: true
end
