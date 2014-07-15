require 'rails_helper'

feature 'user creates a new user', %Q{
  As a site visitor
  I want to add locations to the trips I am planning.
} do

  scenario 'user adds a location' do

    trip = FactoryGirl.create(:trip)
    location = FactoryGirl.build(:location)
    sign_in_as(trip.user)

    visit trip_path(trip)
    fill_in 'Address', with: location.address
    fill_in 'City', with: location.city
    fill_in 'State', with: location.state
    fill_in 'Country', with: location.country
    fill_in 'Area code', with: location.area_code
    click_on 'Create Location'

    expect(page).to have_content 'Success! Your location was added.'
    expect(page).to have_content location.city
  end

  scenario 'user adds multiple locations' do

    trip_leg = FactoryGirl.create(:trip_leg)
    location = FactoryGirl.build(:location)
    sign_in_as(trip_leg.trip.user)

    visit trip_path(trip_leg.trip)
    fill_in 'Address', with: location.address
    fill_in 'City', with: location.city
    fill_in 'State', with: location.state
    fill_in 'Country', with: location.country
    fill_in 'Area code', with: location.area_code
    click_on 'Create Location'

    expect(page).to have_content 'Success! Your location was added.'
    expect(page).to have_content location.city
    expect(page).to have_content "#{ trip_leg.leg.start_location.city }
                                  to #{ location.city }"
  end

  scenario 'without any attributes' do

    trip = FactoryGirl.create(:trip)
    sign_in_as(trip.user)

    visit trip_path(trip)
    click_on 'Create Location'

    expect(page).to_not have_content 'Success'
    expect(page).to have_content "One field must be filled out."
  end

  scenario 'try to create a location with out login' do

    trip = FactoryGirl.create(:trip)

    visit trip_path(trip)
    click_on 'Create Location'

    expect(page).to_not have_content 'Success'
    expect(page).to have_content 'You need to sign in or sign up before continuing.'
  end

  scenario 'try to create a location on not your trip' do

    user = FactoryGirl.create(:user)
    trip = FactoryGirl.create(:trip)
    sign_in_as(user)

    visit trip_path(trip)
    click_on 'Create Location'

    expect(page).to_not have_content 'Success'
    expect(page).to have_content "This is not your trip!"
  end
end
