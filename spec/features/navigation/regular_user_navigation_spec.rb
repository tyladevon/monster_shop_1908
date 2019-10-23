require 'rails_helper'

RSpec.describe "Registered User" do
  describe "User's View" do
    before(:each) do
      @user = User.create(name: "Dee",
                         street_address: "4233 Street",
                         city: "Golden",
                         state: "CO",
                         zip: "80042",
                         email: "deedee@gmail.com",
                         password: "rainbows1908",
                         role: 0)
      visit '/'

      save_and_open_page
      fill_in :email, with: "deedee@gmail.com"
      fill_in :password, with: "rainbows1908"
      click_link "Login"

      expect(current_path).to eq('/profile')
    end
    it "can see some same links in nav bar" do

      expect(page).to have_link "All Items"
      expect(page).to have_link "All Merchants"
      expect(page).to have_link "Home"
      expect(page).to have_content("Cart")
    end

    it "can see additional links in nav bar" do

      expect(page).to have_link "My Profile"
      expect(page).to have_link "Logout"
    end

    it "see's logged in message" do
      expect(page).to have_content("Logged in as ")
    end

    it "cannot see some links in navbar" do

      expect(page).to_not have_link "Login"
      expect(page).to_not have_link "Register"

    end
  end
end
