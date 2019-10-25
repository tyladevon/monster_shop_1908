require 'rails_helper'

RSpec.describe 'As a registered user' do
  describe 'When I view my profile page and I have orders in the system' do
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

      @mike = Merchant.create(name: "Mike's Print Shop", address: '123 Paper Rd.', city: 'Denver', state: 'CO', zip: 80203)
      @paper = @mike.items.create(name: "Lined Paper", description: "Great for writing on!", price: 20, image: "https://cdn.vertex42.com/WordTemplates/images/printable-lined-paper-wide-ruled.png", inventory: 3)
      @pencil = @mike.items.create(name: "Yellow Pencil", description: "You can write on paper with it!", price: 2, image: "https://images-na.ssl-images-amazon.com/images/I/31BlVr01izL._SX425_.jpg", inventory: 100)
      @order_1 = @user.orders.create(name: "Reg", address: "123 Street", city: "Denver", state: "CO", zip: "80202")
      ItemOrder.create(order_id: @order_1.id, item_id: @paper.id, price: 20, quantity: 2)
      ItemOrder.create(order_id: @order_1.id, item_id: @pencil.id, price: 2, quantity: 2)
      @order_1 = @user.orders.create(name: "Reg", address: "123 Street", city: "Denver", state: "CO", zip: "80202")
      ItemOrder.create(order_id: @order_1.id, item_id: @paper.id, price: 20, quantity: 15)
      ItemOrder.create(order_id: @order_1.id, item_id: @pencil.id, price: 2, quantity: 15)

    end
    it "I see a link called My Orders" do
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@user)
    end

    xit "When I click on My Orders, I am redirected to /profile/orders " do

    end
  end
end
