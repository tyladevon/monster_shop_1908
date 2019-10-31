require 'rails_helper'

RSpec.describe "As an admin user" do
  describe "When I visit my admin dashboard" do
    before(:each) do
      @admin = User.create(
        name: "Profile Admin",
        street_address: "456 Ct",
        city: "Austin",
        state: "Texas",
        zip: "70289",
        email: "admin@gmail.com",
        password: "pass",
        password_confirmation: "pass",
        role: 1
      )
      @user = User.create(name: "Dee",
         street_address: "4233 Street",
         city: "Golden",
         state: "CO",
         zip: "80042",
         email: "deedee@gmail.com",
         password: "rainbows1908",
         role: 0)

      @mike = Merchant.create(name: "Mike's Print Shop", address: '123 Paper Rd.', city: 'Denver', state: 'CO', zip: 80203)
      @paper = @mike.items.create(name: "Lined Paper", description: "Great for writing on!", price: 5, image: "https://cdn.vertex42.com/WordTemplates/images/printable-lined-paper-wide-ruled.png", inventory: 3)
      @pencil = @mike.items.create(name: "Yellow Pencil", description: "You can write on paper with it!", price: 2, image: "https://images-na.ssl-images-amazon.com/images/I/31BlVr01izL._SX425_.jpg", inventory: 100)
      @meg = Merchant.create(name: "Meg's Bike Shop", address: '123 Piper Rd.', city: 'Denver', state: 'CO', zip: 80203)
      @tire = @meg.items.create(name: "Gatorskins", description: "They'll never pop!", price: 100, image: "https://www.rei.com/media/4e1f5b05-27ef-4267-bb9a-14e35935f218?size=784x588", inventory: 12)
      @tire_2 = @meg.items.create(name: "Tire Tube", description: "Long distance tube!", price: 49, image: "https://www.rei.com/media/4e1f5b05-27ef-4267-bb9a-14e35935f218?size=784x588", inventory: 12)
      @order_1 = @user.orders.create(name: "Dee", address: "4233 Street", city: "Golden", state: "CO", zip: "80042", user_id: @user.id, status: "Cancelled")
      @order_2 = @user.orders.create(name: "Dee", address: "4233 Street", city: "Golden", state: "CO", zip: "80042", user_id: @user.id, status: "Pending")
      @order_3 = @user.orders.create(name: "Dee", address: "4233 Street", city: "Golden", state: "CO", zip: "80042", user_id: @user.id, status: "Packaged")
      @order_4 = @user.orders.create(name: "Dee", address: "4233 Street", city: "Golden", state: "CO", zip: "80042", user_id: @user.id, status: "Shipped")
      ItemOrder.create(order_id: @order_1.id, item_id: @paper.id, price: 5, quantity: 3)
      ItemOrder.create(order_id: @order_1.id, item_id: @pencil.id, price: 2, quantity: 10)
      ItemOrder.create(order_id: @order_2.id, item_id: @tire.id, price: 100, quantity: 2)
      ItemOrder.create(order_id: @order_2.id, item_id: @tire_2.id, price: 49, quantity: 2)

      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@admin)

      visit "/admin"
    end

    it "I see all orders in the system" do
      expect(page).to have_content("#{@order_1.id}")
      expect(page).to have_content("#{@order_2.id}")
    end

    it "can see information for each order and ordered by status" do
      within "#order-#{@order_1.id}" do
        expect(page).to have_link("#{@order_1.user_id}")
        expect(page).to have_content("#{@order_1.id}")
        expect(page).to have_content("#{@order_1.created_at}")
      end
      within "#order-#{@order_2.id}" do
        expect(page).to have_link("#{@order_2.user_id}")
        expect(page).to have_content("#{@order_2.id}")
        expect(page).to have_content("#{@order_2.created_at}")
      end
  end
end
end
