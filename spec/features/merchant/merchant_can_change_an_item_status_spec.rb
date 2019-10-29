require 'rails_helper'

RSpec.describe 'As a merchant admin' do
  describe "When I visit my items page" do
    before(:each) do
      @mike = Merchant.create(name: "Mike's Print Shop", address: '123 Paper Rd.', city: 'Denver', state: 'CO', zip: 80203)
      @admin_user = User.create(
        name: "Mike",
        street_address: "4233 Street",
        city: "Golden",
        state: "CO",
        zip: "80042",
        email: "mike@gmail.com",
        password: "rainbows1908",
        role: 3,
        merchant_id: @mike.id
      )

      @user = User.create(
        name: "Dee",
        street_address: "4233 Street",
        city: "Golden",
        state: "CO",
        zip: "80042",
        email: "deedee@gmail.com",
        password: "rainbows1908",
        role: 0
      )

      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@admin_user)
      @meg = Merchant.create(name: "Meg's Bike Shop", address: '123 Bike Rd.', city: 'Denver', state: 'CO', zip: 80203)
      @tire = @meg.items.create(name: "Gatorskins", description: "They'll never pop!", price: 100, image: "https://www.rei.com/media/4e1f5b05-27ef-4267-bb9a-14e35935f218?size=784x588", inventory: 12)
      @paper = @mike.items.create(name: "Lined Paper", description: "Great for writing on!", price: 20, image: "https://cdn.vertex42.com/WordTemplates/images/printable-lined-paper-wide-ruled.png", inventory: 3)
      @yellow_pencil = @mike.items.create(name: "Yellow Pencil", description: "You can write on paper with it!", price: 2, image: "https://images-na.ssl-images-amazon.com/images/I/31BlVr01izL._SX425_.jpg", inventory: 100)
      @blue_pencil = @mike.items.create(name: "Blue Pencil", description: "You can write on paper with it!", price: 3, image: "https://images-na.ssl-images-amazon.com/images/I/31BlVr01izL._SX425_.jpg", inventory: 50)
      @green_pencil = @mike.items.create(name: "Green Pencil", description: "You can write on paper with it!", price: 4, image: "https://images-na.ssl-images-amazon.com/images/I/31BlVr01izL._SX425_.jpg", inventory: 20, active?: false)
      visit '/merchant/items'
    end

    it "I see a button to deactivate the item next to each item that is activated" do
      visit '/merchant/items'

      within "#item-#{@paper.id}" do
        click_button "Deactivate"
      end 

      within "#item-#{@paper.id}" do
        expect(page).to have_button("Activate")
      end 
    
      
      expect(page).to have_content("Lined Paper is no longer for sale")
      expect(current_path).to eq("/merchant/items")

      within "#item-#{@green_pencil.id}" do
        expect(page).to_not have_button("Deactivate")
      end
    end


    it "I see a button to activate the item next to each item that is deactivated" do
      visit '/merchant/items'
  
      within "#item-#{@green_pencil.id}" do
        click_button "Activate"
      end 

      within "#item-#{@green_pencil.id}" do
        expect(page).to have_button("Deactivate")
      end 
      
      expect(page).to have_content("Green Pencil is available for sale")
      expect(current_path).to eq("/merchant/items")
    end
  end
end