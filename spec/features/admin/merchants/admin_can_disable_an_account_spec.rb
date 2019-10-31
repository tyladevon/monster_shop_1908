require 'rails_helper'

RSpec.describe 'As an admin user' do
  describe 'When I visit the merchants index page at /merchants' do
    it "I click the disable button to disable a Merchant's account and their items" do
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
      yellow_pencil = bike_shop.items.create(name: "Yellow Pencil", description: "You can write on paper with it!", price: 2, image: "https://images-na.ssl-images-amazon.com/images/I/31BlVr01izL._SX425_.jpg", inventory: 100)
      blue_pencil = bike_shop.items.create(name: "Blue Pencil", description: "You can write on paper with it!", price: 3, image: "https://images-na.ssl-images-amazon.com/images/I/31BlVr01izL._SX425_.jpg", inventory: 50)
      green_pencil = bike_shop.items.create(name: "Green Pencil", description: "You can write on paper with it!", price: 4, image: "https://images-na.ssl-images-amazon.com/images/I/31BlVr01izL._SX425_.jpg", inventory: 20, active?: false)

      visit "/admin/merchants"

      within "#merchant-#{bike_shop.id}" do
        click_button("Disable")
      end

      expect(page).to have_content("Meg's Bike Shop account is disabled.")
      expect(current_path).to eq("/admin/merchants")

      within "#merchant-#{bike_shop.id}" do
        expect(page).to have_button("Enable")
      end

      item_1 = Item.find(yellow_pencil.id)
      item_2 = Item.find(blue_pencil.id)
      item_3 = Item.find(green_pencil.id)
      expect(item_1.active?).to eq(false)
      expect(item_1.active?).to eq(false)
      expect(item_1.active?).to eq(false)
    end
  end
end