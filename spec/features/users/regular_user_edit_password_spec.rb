require 'rails_helper'

RSpec.describe "Regular user visit profile page" do
  describe "can edit password" do
    it "can see link and fill in new password" do
      user = User.create(name: "Dee",
                         street_address: "4233 Street",
                         city: "Golden",
                         state: "CO",
                         zip: "80042",
                         email: "deedee@gmail.com",
                         password: "rainbows1908",
                         role: 0)

    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)
    visit '/profile'
    click_link "Edit Password"
    expect(current_path).to eq("/profile/edit/password")

    fill_in :password, with: "Rainbows1900"
    fill_in :password_confirmation, with: "Rainbows1900"
    click_button "Submit"
    expect(current_path).to eq("/profile")
    expect(page).to have_content("Your password has been updated!")
    end
  end
end
