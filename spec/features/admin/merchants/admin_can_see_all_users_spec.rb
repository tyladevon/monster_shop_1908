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
      dog_shop = Merchant.create(name: "Hill's Dog Shop", address: '123 Dog Rd.', city: 'Austin', state: 'TX', zip: 80203, enabled?: false)
      tire_shop = Merchant.create(name: "Mike's Tire Shop", address: '123 Tire Rd.', city: 'Portland', state: 'OR', zip: 80203)

      visit "/admin/merchants"

      within "#merchant-#{bike_shop.id}" do
        expect(page).to have_link("Meg's Bike Shop")
        expect(page).to have_content("Denver")
        expect(page).to have_content("CO")
        expect(page).to have_button("Disable")
      end

      within "#merchant-#{dog_shop.id}" do
        expect(page).to have_link("Hill's Dog Shop")
        expect(page).to have_content("Austin")
        expect(page).to have_content("TX")
        expect(page).to have_button("Enable")
      end

      within "#merchant-#{tire_shop.id}" do
        expect(page).to have_link("Mike's Tire Shop")
        expect(page).to have_content("Portland")
        expect(page).to have_content("OR")
        expect(page).to have_button("Disable")
      end
    end
  end
end