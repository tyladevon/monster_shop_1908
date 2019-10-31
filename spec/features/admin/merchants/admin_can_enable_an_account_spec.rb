require 'rails_helper'

RSpec.describe 'As an admin user' do
  describe 'When I visit the merchants index page at /merchants' do
    it "I click the enable button to enable a Merchant's account and their items" do
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
      yellow_pencil = dog_shop.items.create(name: "Yellow Pencil", description: "You can write on paper with it!", price: 2, image: "https://images-na.ssl-images-amazon.com/images/I/31BlVr01izL._SX425_.jpg", inventory: 100, active?: false)
      blue_pencil = dog_shop.items.create(name: "Blue Pencil", description: "You can write on paper with it!", price: 3, image: "https://images-na.ssl-images-amazon.com/images/I/31BlVr01izL._SX425_.jpg", inventory: 50)
      green_pencil = dog_shop.items.create(name: "Green Pencil", description: "You can write on paper with it!", price: 4, image: "https://images-na.ssl-images-amazon.com/images/I/31BlVr01izL._SX425_.jpg", inventory: 20, active?: false)
      
      visit "/admin/merchants"

      within "#merchant-#{dog_shop.id}" do
        click_button("Enable")
      end

      expect(page).to have_content("Hill's Dog Shop account is enabled.")
      expect(current_path).to eq("/admin/merchants")

      within "#merchant-#{dog_shop.id}" do
        expect(page).to have_button("Disable")
      end

      item_1 = Item.find(yellow_pencil.id)
      item_2 = Item.find(blue_pencil.id)
      item_3 = Item.find(green_pencil.id)
      expect(item_1.active?).to eq(true)
      expect(item_1.active?).to eq(true)
      expect(item_1.active?).to eq(true)
    end
  end
end