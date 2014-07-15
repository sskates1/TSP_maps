require 'rails_helper'

feature 'user creates a new trip', %Q{
  As a site visitor
  I want to add a new trip to plan
} do

  scenario 'user tries to create a trip without login' do

    visit new_trip_path

    expect(page).to have_content 'You need to sign in or sign up before continuing.'
  end

  scenario 'trip without required attributes' do

    user = FactoryGirl.create(:user)
    sign_in_as(user)

    visit new_trip_path
    click_on 'Submit'

    expect(page).to_not have_content 'successfully'
    expect(page).to have_content "can't be blank"
  end

  scenario 'user creates a new trip' do

    trip = FactoryGirl.build(:trip)

    sign_in_as(trip.user)

    visit new_trip_path
    fill_in 'Name', with: trip.name
    choose(trip.mode)
    click_on 'Submit'

    expect(page).to have_content 'Success'
    expect(page).to have_content trip.name
  end
end
