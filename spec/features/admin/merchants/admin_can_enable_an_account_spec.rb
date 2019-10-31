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
      dog_shop = Merchant.create(name: "Hill's Dog Shop", address: '123 Dog Rd.', city: 'Austin', state: 'TX', zip: 80203, enabled?: false)

      visit "/admin/merchants"

      within "#merchant-#{dog_shop.id}" do
        click_button("Enable")
      end

      expect(page).to have_content("Hill's Dog Shop account is enabled.")
      expect(current_path).to eq("/admin/merchants")

      within "#merchant-#{dog_shop.id}" do
        expect(page).to have_button("Disable")
      end
    end
  end
end