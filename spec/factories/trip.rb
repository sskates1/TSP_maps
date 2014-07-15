# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :trip, :class => 'Trip' do
    name 'East Coast'
    mode 'Driving'

    user
  end
end
