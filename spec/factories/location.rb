# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :location, :class => 'Location' do
    sequence(:address, 100) {|n| "#{n} Harvard st."}
    city 'Cambridge'
    state 'MA'
    country 'USA'
    area_code '02139'
  end
end
