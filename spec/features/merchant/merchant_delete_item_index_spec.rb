require 'rails_helper'

RSpec.describe "As a merchant admin" do
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
      @binder = @mike.items.create(name: "Straight Forward Binder", description: "You need a school binder!", price: 5, image: "https://www.pbteen.com/ptimgs/ab/images/dp/wcm/201940/0434/img59o.jpg", inventory: 12)
      @paper = @mike.items.create(name: "Lined Paper", description: "Great for writing on!", price: 20, image: "https://cdn.vertex42.com/WordTemplates/images/printable-lined-paper-wide-ruled.png", inventory: 3)
      @pencil = @mike.items.create(name: "Yellow Pencil", description: "You can write on paper with it!", price: 2, image: "https://images-na.ssl-images-amazon.com/images/I/31BlVr01izL._SX425_.jpg", inventory: 100)
      @order_1 = @user.orders.create(name: "Reg", address: "123 Street", city: "Denver", state: "CO", zip: "80202", user_id: @user.id)
      @item_order_1 = ItemOrder.create(order_id: @order_1.id, item_id: @paper.id, price: 20, quantity: 2)
      @item_order_2 = ItemOrder.create(order_id: @order_1.id, item_id: @pencil.id, price: 2, quantity: 2)

      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@admin_user)
      visit "/merchant"
      click_link "My Items"
    end

    it "I see a button to delete the item next to each item that has never been ordered" do
      within "#item-#{@binder.id}" do
        expect(page).to have_button("Delete")
      end
      within "#item-#{@paper.id}" do
        expect(page).to_not have_button("Delete")
      end
      within "#item-#{@pencil.id}" do
        expect(page).to_not have_button("Delete")
      end

    end

    it "when I click on the 'delete' button next to item" do
      within "#item-#{@binder.id}" do
        click_button "Delete"
      end

      expect(current_path).to eq("/merchant/items")
      expect(page).to have_content("Your Straight Forward Binder has been deleted")
      expect(page).to_not have_content("price: 5")
      expect(page).to_not have_content("description: You need a school binder!")
      end
    end
  end
