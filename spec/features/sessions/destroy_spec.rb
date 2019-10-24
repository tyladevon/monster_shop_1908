require 'rails_helper'

RSpec.describe "Session destroy" do
  describe "As a registered user, merchant, or admin" do
    describe "When I visit the logout path" do
      it 'I am redirected to the welcome / home page of the site' do
        user = User.create(
          name: "Bob G",
          street_address: "123 Avenue",
          city: "Portland",
          state: "OR",
          zip: "30203",
          email: "bobg2@agency.com",
          password: "bobg",
          password_confirmation: "bobg",
          role: 2
        )

        visit '/login'

        fill_in :email, with: "bobg2@agency.com"
        fill_in :password, with: "bobg"

        click_button 'Login'
        click_link "Logout"
        save_and_open_page

        expect(current_path).to eq("/")
        expect(page).to have_content("You have been successfully logged out!")

        within 'nav' do
          expect(page).to have_content("Cart: 0")
        end
      end
    end
  end
end