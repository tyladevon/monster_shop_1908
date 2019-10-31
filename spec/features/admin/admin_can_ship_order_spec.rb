require 'rails_helper'

describe 'As an admin user' do
  describe 'When I log into my admin dashboard' do
    before(:each) do
      @admin_user = User.create(name: "Bob G",
        street_address: "123 Avenue",
        city: "Portland",
        state: "OR",
        zip: "30203",
        email: "bobg@agency.com",
        password: "bobg",
        password_confirmation: "bobg",
        role: 1)

        allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@admin_user)

        @user = User.create(
          name: "Dee",
          street_address: "4233 Street",
          city: "Golden",
          state: "CO",
          zip: "80042",
          email: "deedee@gmail.com",
          password: "rainbows1908",
          role: 0)

      @mike = Merchant.create(name: "Mike's Print Shop", address: '123 Paper Rd.', city: 'Denver', state: 'CO', zip: 80203)
      @paper = @mike.items.create(name: "Lined Paper", description: "Great for writing on!", price: 20, image: "https://cdn.vertex42.com/WordTemplates/images/printable-lined-paper-wide-ruled.png", inventory: 3)
      @pencil = @mike.items.create(name: "Yellow Pencil", description: "You can write on paper with it!", price: 2, image: "https://images-na.ssl-images-amazon.com/images/I/31BlVr01izL._SX425_.jpg", inventory: 100)
      @order_1 = @user.orders.create(name: "Reg", address: "123 Street", city: "Denver", state: "CO", zip: "80202", user_id: @user.id, status: "Packaged")
      @order_2 = @user.orders.create(name: "Dude", address: "123 Street", city: "Denver", state: "CO", zip: "80202", user_id: @user.id, status: "Pending")
      @item_order_1 = ItemOrder.create(order_id: @order_1.id, item_id: @paper.id, price: 20, quantity: 2, fulfilled: true)
      @item_order_2 = ItemOrder.create(order_id: @order_1.id, item_id: @pencil.id, price: 2, quantity: 101, fulfilled: true)
      @item_order_3 = ItemOrder.create(order_id: @order_2.id, item_id: @pencil.id, price: 2, quantity: 101, fulfilled: false)
      @item_order_4 = ItemOrder.create(order_id: @order_2.id, item_id: @pencil.id, price: 2, quantity: 101, fulfilled: false)


      visit '/admin'
    end
    it "I see any packaged orders that are ready to ship" do
      expect(page).to have_content("Order Id: #{@order_1.id}")
      expect(page).to have_content(@order_1.status)
      expect(page).to have_content(@order_1.user_id)
    end

    it "Next to each packaged order I see a ship button" do
      within "#order-#{@order_1.id}" do
        expect(page).to have_button('Ship Order')
      end
    end

    it "When I click the button, the status of the order becomes 'shipped'" do
      click_button 'Ship Order'

      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@user)

      visit '/profile/orders'

      expect(page).to have_content("Status: Shipped")
    end

    it "The ordering user can no longer cancel a shipped order" do
      click_button 'Ship Order'

      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@user)
      visit "/profile/orders/#{@order_1.id}"

      expect(page).to_not have_button('Cancel Order')
    end
  end
end
