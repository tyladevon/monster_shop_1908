require 'rails_helper'

describe "As a registered user" do
  describe "I visit my profile orders page" do
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
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@user)

      @mike = Merchant.create(name: "Mike's Print Shop", address: '123 Paper Rd.', city: 'Denver', state: 'CO', zip: 80203)
      @paper = @mike.items.create(name: "Lined Paper", description: "Great for writing on!", price: 20, image: "https://cdn.vertex42.com/WordTemplates/images/printable-lined-paper-wide-ruled.png", inventory: 3)
      @pencil = @mike.items.create(name: "Yellow Pencil", description: "You can write on paper with it!", price: 2, image: "https://images-na.ssl-images-amazon.com/images/I/31BlVr01izL._SX425_.jpg", inventory: 100)
      @order_1 = @user.orders.create(name: "Reg", address: "123 Street", city: "Denver", state: "CO", zip: "80202", user_id: @user.id)
      ItemOrder.create(order_id: @order_1.id, item_id: @paper.id, price: 20, quantity: 2)
      ItemOrder.create(order_id: @order_1.id, item_id: @pencil.id, price: 2, quantity: 2)

      visit '/profile/orders'
    end

    it "I see details of every order I've made" do
      within "#order-#{@order_1.id}" do
        expect(page).to have_link(@order_1.id)
        expect(page).to have_content(@order_1.created_at)
        expect(page).to have_content(@order_1.updated_at)
        expect(page).to have_content(@order_1.status)
        expect(page).to have_content(@order_1.total_items)
        expect(page).to have_content(@order_1.grandtotal)
      end
    end

    describe "When I click on link of the id, I am brought to that order's show page" do
      it "can see all information of that order" do

        click_link "#{@order_1.id}"

        expect(current_path).to eq("/profile/orders/#{@order_1.id}")
        expect(page).to have_content(@order_1.id)
        expect(page).to have_content(@order_1.created_at)
        expect(page).to have_content(@order_1.updated_at)
        expect(page).to have_content(@order_1.status)

        expect(page).to have_content(@paper.name)
        expect(page).to have_content(@paper.description)
        expect(page).to have_css("img[src*='printable-lined-paper-wide-ruled.png']")
        expect(page).to have_content(2)
        expect(page).to have_content(@paper.price)
        expect(page).to have_content("$40.00")
        expect(page).to have_content(@pencil.name)
        expect(page).to have_content(@pencil.description)
        expect(page).to have_css("img[src*='I/31BlVr01izL._SX425_.jpg']")
        expect(page).to have_content(2)
        expect(page).to have_content(@pencil.price)
        expect(page).to have_content("$4.00")

        expect(page).to have_content(@order_1.total_items)
        expect(page).to have_content(@order_1.grandtotal)
      end
    end
  end
end
