require 'rails_helper'

describe Item, type: :model do
  describe "validations" do
    it { should validate_presence_of :name }
    it { should validate_presence_of :description }
    it { should validate_presence_of :price }
    it { should validate_presence_of :image }
    it { should validate_presence_of :inventory }
    it { should validate_inclusion_of(:active?).in_array([true,false]) }
  end

  describe "relationships" do
    it {should belong_to :merchant}
    it {should have_many :reviews}
    it {should have_many :item_orders}
    it {should have_many(:orders).through(:item_orders)}
  end

  describe "instance methods" do
    before(:each) do
      @bike_shop = Merchant.create(name: "Brian's Bike Shop", address: '123 Bike Rd.', city: 'Denver', state: 'CO', zip: 80203)
      @chain = @bike_shop.items.create(name: "Chain", description: "It'll never break!", price: 50, image: "https://www.rei.com/media/b61d1379-ec0e-4760-9247-57ef971af0ad?size=784x588", inventory: 5)

      @review_1 = @chain.reviews.create(title: "Great place!", content: "They have great bike stuff and I'd recommend them to anyone.", rating: 5)
      @review_2 = @chain.reviews.create(title: "Cool shop!", content: "They have cool bike stuff and I'd recommend them to anyone.", rating: 4)
      @review_3 = @chain.reviews.create(title: "Meh place", content: "They have meh bike stuff and I probably won't come back", rating: 1)
      @review_4 = @chain.reviews.create(title: "Not too impressed", content: "v basic bike shop", rating: 2)
      @review_5 = @chain.reviews.create(title: "Okay place :/", content: "Brian's cool and all but just an okay selection of items", rating: 3)

    end

    it "calculate average review" do
      expect(@chain.average_review).to eq(3.0)
    end

    it "sorts reviews" do
      top_three = @chain.sorted_reviews(3,:desc)
      bottom_three = @chain.sorted_reviews(3,:asc)

      expect(top_three).to eq([@review_1,@review_2,@review_5])
      expect(bottom_three).to eq([@review_3,@review_4,@review_5])
    end

    it 'no orders' do
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
      expect(@chain.no_orders?).to eq(true)
      order = Order.create(name: 'Meg', address: '123 Stang Ave', city: 'Hershey', state: 'PA', zip: 17033, user_id: user.id)
      order.item_orders.create(item: @chain, price: @chain.price, quantity: 2)
      expect(@chain.no_orders?).to eq(false)
    end
  end

  describe "class methods" do
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
    end

    it 'top_five_most_popular' do
      pop = Item.top_five_most_popular
      expect(pop[0].name).to eq(@folder.name)
      expect(pop[0].sumq).to eq(10)
      expect(pop[1].name).to eq(@college_rule.name)
      expect(pop[1].sumq).to eq(9)
      expect(pop[2].name).to eq(@divider.name)
      expect(pop[2].sumq).to eq(8)
      expect(pop[3].name).to eq(@pen.name)
      expect(pop[3].sumq).to eq(7)
      expect(pop[4].name).to eq(@paper.name)
      expect(pop[4].sumq).to eq(6)
    end

    it 'least_popular' do
      unpop = Item.least_popular
      expect(unpop[0].name).to eq(@ruler.name)
      expect(unpop[0].sumq).to eq(1)
      expect(unpop[1].name).to eq(@binder.name)
      expect(unpop[1].sumq).to eq(2)
      expect(unpop[2].name).to eq(@tape.name)
      expect(unpop[2].sumq).to eq(3)
      expect(unpop[3].name).to eq(@pencil.name)
      expect(unpop[3].sumq).to eq(4)
      expect(unpop[4].name).to eq(@wide_rule.name)
      expect(unpop[4].sumq).to eq(5)
    end
  end
end
