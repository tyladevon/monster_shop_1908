require 'rails_helper'

RSpec.describe 'item delete', type: :feature do
  describe 'when I visit an item show page' do
    before(:each) do
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
    end
    it 'I cannot delete an item' do
      bike_shop = Merchant.create(name: "Brian's Bike Shop", address: '123 Bike Rd.', city: 'Denver', state: 'CO', zip: 80203)
      chain = bike_shop.items.create(name: "Chain", description: "It'll never break!", price: 50, image: "https://www.rei.com/media/b61d1379-ec0e-4760-9247-57ef971af0ad?size=784x588", inventory: 5)

      visit "/items/#{chain.id}"

      expect(page).to_not have_link("Delete Item")
    end
  end
end
