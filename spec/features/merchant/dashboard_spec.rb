require 'rails_helper'

describe "As a Merchant Employee or Admin" do
  describe "when I visit my dashboard" do
    it "can see name and address of Merchant I work for" do
      bike_shop = Merchant.create(name: "Brian's Bike Shop", address: '123 Bike Rd.', city: 'Richmond', state: 'VA', zip: 23137)

      user = User.create(name: "Dee",
                         street_address: "4233 Street",
                         city: "Golden",
                         state: "CO",
                         zip: "80042",
                         email: "deedee@gmail.com",
                         password: "rainbows1908",
                         role: 2,
                         merchant_id: bike_shop.id)

      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

      visit ("/merchant")

      expect(page).to have_content("Brian's Bike Shop")
      expect(page).to have_content(bike_shop.address)
      expect(page).to have_content(bike_shop.city)
      expect(page).to have_content(bike_shop.state)
      expect(page).to have_content(bike_shop.zip)
    end
  end
end
