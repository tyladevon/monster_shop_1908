require 'rails_helper'

RSpec.describe 'As a merchant employee or admin' do
  describe 'When I visit an order show page from my dashboard' do
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
        role: 2,
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
      @pencil = @mike.items.create(name: "Yellow Pencil", description: "You can write on paper with it!", price: 2, image: "https://images-na.ssl-images-amazon.com/images/I/31BlVr01izL._SX425_.jpg", inventory: 100)
      @order_1 = @user.orders.create(name: "Reg", address: "123 Street", city: "Denver", state: "CO", zip: "80202", user_id: @user.id)
      ItemOrder.create(order_id: @order_1.id, item_id: @paper.id, price: 20, quantity: 2)
      ItemOrder.create(order_id: @order_1.id, item_id: @pencil.id, price: 2, quantity: 2)
      ItemOrder.create(order_id: @order_1.id, item_id: @tire.id, price: 100, quantity: 1)
      visit '/merchant'
      click_link "#{@order_1.id}"
    end

    it 'I see the customers name and address' do
      expect(page).to have_content("Reg") 
      expect(page).to have_content("123 Street") 
      expect(page).to have_content("Denver") 
      expect(page).to have_content("CO") 
      expect(page).to have_content("80202") 
    end

    it "I can see only items in the order that belong to my merchant" do
      expect(page).to have_content(@paper.name)
      expect(page).to have_css("img[src*='#{@paper.image}']")
      expect(page).to have_content("Price: $20.00")
      expect(page).to have_content("Quantity: 2")
      
      expect(page).to have_content(@pencil.name)
      expect(page).to have_css("img[src*='#{@pencil.image}']")
      expect(page).to have_content("Price: $2.00")
      expect(page).to have_content("Quantity: 2")
    end

    it "I do not see other merchants items that belong to the order" do
      expect(page).to_not have_content(@tire.name)
      expect(page).to_not have_css("img[src*='#{@tire.image}']")
      expect(page).to_not have_content("Price: $100.00")
      expect(page).to_not have_content("Quantity: 1")
    end
  end 
end
