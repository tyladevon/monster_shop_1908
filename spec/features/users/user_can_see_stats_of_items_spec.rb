require 'rails_helper'

RSpec.describe "As any kind of user on the system" do
  describe "When I visit the items index page" do
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

      @paper = @mike.items.create(name: "Lined Paper", description: "Great for writing on!", price: 5, image: "https://cdn.vertex42.com/WordTemplates/images/printable-lined-paper-wide-ruled.png", inventory: 100)
      @pencil = @mike.items.create(name: "Yellow Pencil", description: "You can write on paper with it!", price: 2, image: "https://images-na.ssl-images-amazon.com/images/I/31BlVr01izL._SX425_.jpg", inventory: 100)
      @pen = @mike.items.create(name: "Black Pen", description: "You can write!", price: 4, image: "https://images-na.ssl-images-amazon.com/images/I/31BlVr01izL._SX425_.jpg", inventory: 100)
      @binder = @mike.items.create(name: "Binder", description: "You can hold papers!", price: 8, image: "https://images-na.ssl-images-amazon.com/images/I/31BlVr01izL._SX425_.jpg", inventory: 100)
      @ruler = @mike.items.create(name: "Ruler", description: "You can write measure!", price: 3, image: "https://images-na.ssl-images-amazon.com/images/I/31BlVr01izL._SX425_.jpg", inventory: 100)
      @wide_rule = @mike.items.create(name: "Wide Rule Paper", description: "You can write on it!", price: 4, image: "https://images-na.ssl-images-amazon.com/images/I/31BlVr01izL._SX425_.jpg", inventory: 100)
      @college_rule = @mike.items.create(name: "College Rule Paper", description: "You can write on it!", price: 4, image: "https://images-na.ssl-images-amazon.com/images/I/31BlVr01izL._SX425_.jpg", inventory: 100)
      @divider = @mike.items.create(name: "Colorful Dividers", description: "You can devide!", price: 4, image: "https://images-na.ssl-images-amazon.com/images/I/31BlVr01izL._SX425_.jpg", inventory: 100)
      @folder = @mike.items.create(name: "Simple Folder", description: "You can organize with it!", price: 2, image: "https://images-na.ssl-images-amazon.com/images/I/31BlVr01izL._SX425_.jpg", inventory: 100)
      @tape = @mike.items.create(name: "Tape", description: "You can tape with it!", price: 5, image: "https://images-na.ssl-images-amazon.com/images/I/31BlVr01izL._SX425_.jpg", inventory: 100)

      @order_1 = @user.orders.create(name: "Reg", address: "123 Street", city: "Denver", state: "CO", zip: "80202", user_id: @user.id)
      ItemOrder.create(order_id: @order_1.id, item_id: @ruler.id, price: 3, quantity: 1)
      ItemOrder.create(order_id: @order_1.id, item_id: @binder.id, price: 8, quantity: 2)
      ItemOrder.create(order_id: @order_1.id, item_id: @tape.id, price: 5, quantity: 3)
      ItemOrder.create(order_id: @order_1.id, item_id: @pencil.id, price: 2, quantity: 4)
      ItemOrder.create(order_id: @order_1.id, item_id: @wide_rule.id, price: 4, quantity: 5)
      ItemOrder.create(order_id: @order_1.id, item_id: @paper.id, price: 5, quantity: 6)
      ItemOrder.create(order_id: @order_1.id, item_id: @pen.id, price: 4, quantity: 7)
      ItemOrder.create(order_id: @order_1.id, item_id: @divider.id, price: 4, quantity: 8)
      ItemOrder.create(order_id: @order_1.id, item_id: @college_rule.id, price: 4, quantity: 9)
      ItemOrder.create(order_id: @order_1.id, item_id: @folder.id, price: 2, quantity: 10)
      visit "/items"
    end
    it "I see an area with statistics" do
      expect(page).to have_content("Statistics:")

      within ".Statistics" do
        expect(page).to have_content("Top 5 Most Popular Items")
        expect(page).to have_content("Least Popular Items--bottom 5")
      end
    end

  end
end
