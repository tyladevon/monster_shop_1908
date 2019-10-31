require 'rails_helper'

RSpec.describe "As a Visitor" do
  describe "When I visit an Item Show Page" do
    describe "I can't see a link to edit item since I am not an admin" do
      it 'I can see the prepopulated fields of that item' do
        @meg = Merchant.create(name: "Meg's Bike Shop", address: '123 Bike Rd.', city: 'Denver', state: 'CO', zip: 80203)
        @tire = @meg.items.create(name: "Gatorskins", description: "They'll never pop!", price: 100, image: "https://www.rei.com/media/4e1f5b05-27ef-4267-bb9a-14e35935f218?size=784x588", inventory: 12)

        visit "/items/#{@tire.id}"

        expect(page).to_not have_link("Edit Item")
      end
    end
  end
end
