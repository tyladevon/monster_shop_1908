require 'rails_helper'

RSpec.describe "Session destroy" do
  describe "As a registered user, merchant, or admin" do
    describe "When I visit the logout path" do
      it 'I am redirected to the welcome / home page of the site' do
        meg = Merchant.create(name: "Meg's Bike Shop", address: '123 Bike Rd.', city: 'Denver', state: 'CO', zip: 80203)

        user = User.create(
          name: "Bob G",
          street_address: "123 Avenue",
          city: "Portland",
          state: "OR",
          zip: "30203",
          email: "bobg2@agency.com",
          password: "bobg",
          password_confirmation: "bobg",
          role: 2,
          merchant_id: meg.id
        )

        visit '/login'

        fill_in :email, with: "bobg2@agency.com"
        fill_in :password, with: "bobg"

        click_button 'Login'
        click_link "Logout"

        expect(current_path).to eq("/")
        expect(page).to have_content("You have been successfully logged out!")

        within 'nav' do
          expect(page).to have_content("Cart: 0")
        end
      end
    end
  end
end
