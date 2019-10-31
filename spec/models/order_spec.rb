require 'rails_helper'

describe Order, type: :model do
  describe "validations" do
    it { should validate_presence_of :name }
    it { should validate_presence_of :address }
    it { should validate_presence_of :city }
    it { should validate_presence_of :state }
    it { should validate_presence_of :zip }
    it { should validate_presence_of :status }
  end

  describe "relationships" do
    it {should have_many :item_orders}
    it {should have_many(:items).through(:item_orders)}
    it { should belong_to :user}
  end

  describe 'instance methods' do
    before :each do
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
      @meg = Merchant.create(name: "Meg's Bike Shop", address: '123 Bike Rd.', city: 'Denver', state: 'CO', zip: 80203)
      @brian = Merchant.create(name: "Brian's Dog Shop", address: '125 Doggo St.', city: 'Denver', state: 'CO', zip: 80210)

      @tire = @meg.items.create(name: "Gatorskins", description: "They'll never pop!", price: 100, image: "https://www.rei.com/media/4e1f5b05-27ef-4267-bb9a-14e35935f218?size=784x588", inventory: 12)
      @pull_toy = @brian.items.create(name: "Pull Toy", description: "Great pull toy!", price: 10, image: "http://lovencaretoys.com/image/cache/dog/tug-toy-dog-pull-9010_2-800x800.jpg", inventory: 32)

      @order_1 = Order.create!(name: 'Meg', address: '123 Stang Ave', city: 'Hershey', state: 'PA', zip: 17033, user_id: @user.id)

      @order_1.item_orders.create!(item: @tire, price: @tire.price, quantity: 2)
      @order_1.item_orders.create!(item: @pull_toy, price: @pull_toy.price, quantity: 3)
    end

    it 'grandtotal' do
      expect(@order_1.grandtotal).to eq(230)
    end

    it 'total_items' do
      expect(@order_1.total_items).to eq(5)
    end

    it 'grouped_by_status' do
      @order_2 = @user.orders.create(name: "Dee", address: "4233 Street", city: "Golden", state: "CO", zip: "80042", user_id: @user.id, status: "Cancelled")
      @order_3 = @user.orders.create(name: "Dee", address: "4233 Street", city: "Golden", state: "CO", zip: "80042", user_id: @user.id, status: "Pending")
      @order_4 = @user.orders.create(name: "Dee", address: "4233 Street", city: "Golden", state: "CO", zip: "80042", user_id: @user.id, status: "Packaged")
      @order_5 = @user.orders.create(name: "Dee", address: "4233 Street", city: "Golden", state: "CO", zip: "80042", user_id: @user.id, status: "Shipped")

      expect(Order.grouped_by_status.to_a).to eq([@order_4, @order_1, @order_3, @order_5, @order_2])
    end
  end
end
