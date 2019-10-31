require 'rails_helper'

RSpec.describe 'As an admin user' do
  describe 'When I visit the merchants index page at /merchants' do
    it "I see all merchants in the system" do
      mike = Merchant.create(name: "Mike's Print Shop", address: '123 Paper Rd.', city: 'Denver', state: 'CO', zip: 80203)      
      admin_user = User.create(
        name: "Mike",
        street_address: "4233 Street",
        city: "Golden",
        state: "CO",
        zip: "80042",
        email: "mike@gmail.com",
        password: "rainbows1908",
        role: 1,
        merchant_id: mike.id
      )

      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(admin_user)
      bike_shop = Merchant.create(name: "Meg's Bike Shop", address: '123 Bike Rd.', city: 'Denver', state: 'CO', zip: 80203)

      visit "/admin/merchants"

      within "#merchant-#{bike_shop.id}" do
        click_button("Disable")
      end

      expect(page).to have_content("Meg's Bike Shop account is disabled.")
      expect(current_path).to eq("/admin/merchants")

      within "#merchant-#{bike_shop.id}" do
        expect(page).to have_button("Enable")
      end
    end
  end
end