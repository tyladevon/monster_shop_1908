require 'rails_helper'

describe ItemOrder, type: :model do
  describe "validations" do
    it { should validate_presence_of :order_id }
    it { should validate_presence_of :item_id }
    it { should validate_presence_of :price }
    it { should validate_presence_of :quantity }
  end

  describe "relationships" do
    it {should belong_to :item}
    it {should belong_to :order}
  end

  describe 'instance methods' do
    before(:each) do
      @user = User.create(
        name: "Dee",
        street_address: "4233 Street",
        city: "Golden",
        state: "CO",
        zip: "80042",
        email: "deedee@gmail.com",
        password: "rainbows1908",
        role: 0)
    end
    it 'subtotal' do
      user = User.create(
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
      meg = Merchant.create(name: "Meg's Bike Shop", address: '123 Bike Rd.', city: 'Denver', state: 'CO', zip: 80203)
      tire = meg.items.create(name: "Gatorskins", description: "They'll never pop!", price: 100, image: "https://www.rei.com/media/4e1f5b05-27ef-4267-bb9a-14e35935f218?size=784x588", inventory: 12)
      order_1 = Order.create!(name: 'Meg', address: '123 Stang Ave', city: 'Hershey', state: 'PA', zip: 17033, user_id: user.id)
      item_order_1 = order_1.item_orders.create!(item: tire, price: tire.price, quantity: 2)

      expect(item_order_1.subtotal).to eq(200)
    end

    it "filter_item_order" do
      meg = Merchant.create(name: "Meg's Bike Shop", address: '123 Bike Rd.', city: 'Denver', state: 'CO', zip: 80203)
      mike = Merchant.create(name: "Mike's Print Shop", address: '123 Paper Rd.', city: 'Denver', state: 'CO', zip: 80203)
      tire = meg.items.create(name: "Gatorskins", description: "They'll never pop!", price: 100, image: "https://www.rei.com/media/4e1f5b05-27ef-4267-bb9a-14e35935f218?size=784x588", inventory: 12)
      order_1 = @user.orders.create(name: "Reg", address: "123 Street", city: "Denver", state: "CO", zip: "80202", user_id: @user.id)
      item_order_1 = ItemOrder.create(order_id: order_1.id, item_id: tire.id, price: 100, quantity: 1)

      expect(item_order_1.filter_item_order(meg.id)).to eq(true)
      expect(item_order_1.filter_item_order(mike.id)).to eq(false)
    end

    it "can_be_fulfilled" do
      mike = Merchant.create(name: "Mike's Print Shop", address: '123 Paper Rd.', city: 'Denver', state: 'CO', zip: 80203)
      paper = mike.items.create(name: "Lined Paper", description: "Great for writing on!", price: 20, image: "https://cdn.vertex42.com/WordTemplates/images/printable-lined-paper-wide-ruled.png", inventory: 3)
      pencil = mike.items.create(name: "Yellow Pencil", description: "You can write on paper with it!", price: 2, image: "https://images-na.ssl-images-amazon.com/images/I/31BlVr01izL._SX425_.jpg", inventory: 100)
      order_1 = @user.orders.create(name: "Reg", address: "123 Street", city: "Denver", state: "CO", zip: "80202", user_id: @user.id)
      item_order_1 = ItemOrder.create(order_id: order_1.id, item_id: paper.id, price: 20, quantity: 2)
      item_order_2 = ItemOrder.create(order_id: order_1.id, item_id: pencil.id, price: 2, quantity: 101)

      expect(item_order_1.can_be_fulfilled?).to eq(true)
      expect(item_order_2.can_be_fulfilled?).to eq(false)
    end
  end

end
