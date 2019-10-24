require 'rails_helper'

RSpec.describe "Regular user visits items index" do
  it "can see items catalog" do
  dog_shop = Merchant.create(name: "Brian's Dog Shop", address: '125 Doggo St.', city: 'Denver', state: 'CO', zip: 80210)
  pull_toy = dog_shop.items.create(name: "Pull Toy", description: "Great pull toy!", price: 10, image: "http://lovencaretoys.com/image/cache/dog/tug-toy-dog-pull-9010_2-800x800.jpg", inventory: 32)
  dog_bone = dog_shop.items.create(name: "Dog Bone", description: "They'll love it!", price: 21, image: "https://img.chewy.com/is/image/catalog/54226_MAIN._AC_SL1500_V1534449573_.jpg", active?:false, inventory: 21)

  @user = User.create(name: "Dee",
                     street_address: "4233 Street",
                     city: "Golden",
                     state: "CO",
                     zip: "80042",
                     email: "deedee@gmail.com",
                     password: "rainbows1908",
                     role: 0)

  allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@user)

  visit '/items'

  expect(page).to have_content("Pull Toy")
  expect(page).to_not have_content("Dog Bone")
  # save_and_open_page
  find(".item-link-image").click
  expect(current_path).to eq ("/items/#{pull_toy.id}")
  end
end
