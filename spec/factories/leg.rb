# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :leg, :class => 'Leg' do
    distance 350
    distance_unit 'km'
    association :start_location, factory: :location
    association :end_location, factory: :location
  end
end
