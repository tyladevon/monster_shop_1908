require 'rails_helper'

RSpec.describe "As a merchant employee or admin" do
  describe "When I visit my merchant dashboard" do
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
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@admin_user)

      visit "/merchant"
    end

    it "I see a link to view my own items" do
      click_link "My Items"
      expect(current_path).to eq("/merchant/items")
    end
  end
end
