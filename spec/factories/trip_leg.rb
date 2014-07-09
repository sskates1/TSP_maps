# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :trip_leg, :class => 'TripLeg' do
    sequence(:time, 5000) {|n| n}

    leg
    trip
  end
end
