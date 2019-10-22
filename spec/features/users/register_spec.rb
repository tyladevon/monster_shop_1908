require 'rails_helper'

RSpec.describe "Visitor Registration" do
  it "can register" do
    visit '/'
    click_link "Register"
    expect(current_path).to eq("/register")

    fill_in :name, with: "Bob G"
    fill_in :street_address, with: "5345 Address"
    fill_in :city, with: "Denver"
    fill_in :state, with: "CO"
    fill_in :zip, with: "80210"
    fill_in :email, with: "bobg@gmail.com"
    fill_in :password, with: "bobg121!"
    fill_in :password_confirmation, with: "bobg121!"

    # sad path testing for fill in form completely.
    # add unique email address
    # logged in from user registration

    click_button "Submit"
    expect(current_path).to eq("/profile")
    expect(page).to have_content("You are now registered and logged in!")
  end
end
