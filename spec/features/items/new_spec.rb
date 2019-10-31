require 'rails_helper'

RSpec.describe "Create Merchant Items" do
  describe "When I visit the merchant items index page" do
    before(:each) do
      @brian = Merchant.create(name: "Brian's Dog Shop", address: '125 Doggo St.', city: 'Denver', state: 'CO', zip: 80210)
    end

    it 'I do not see a link to add a new item for that merchant when I am not an admin' do
      visit "/merchants/#{@brian.id}/items"

      expect(page).to_not have_link "Add New Item"
    end
  end
end
