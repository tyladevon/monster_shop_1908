require 'rails_helper'

RSpec.describe "As an admin user" do
  describe "When I visit a user's profile page"
    before(:each) do
      @admin = User.create(
        name: "Profile Admin",
        street_address: "456 Ct",
        city: "Austin",
        state: "Texas",
        zip: "70289",
        email: "admin@gmail.com",
        password: "pass",
        password_confirmation: "pass",
        role: 1
      )
      @user = User.create(
        name: "Profile User",
        street_address: "345 Blvd",
        city: "San Antonio",
        state: "Texas",
        zip: "60789",
        email: "profile@gmail.com",
        password: "pass",
        password_confirmation: "pass",
        role: 0
      )
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@admin)

    visit "/admin/users/#{@user.id}"
      save_and_open_page
    end

    it "I see the same information the user would see themselves" do
      expect(page).to have_content(@user.name)
      expect(page).to have_content(@user.street_address)
      expect(page).to have_content(@user.city)
      expect(page).to have_content(@user.state)
      expect(page).to have_content(@user.zip)
      expect(page).to have_content(@user.email)
    end

    it "I do not see a link to edit their profile" do
      expect(page).to_not have_link('Edit Profile')
    end
end
