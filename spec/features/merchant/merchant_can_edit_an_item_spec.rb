require 'rails_helper'

describe 'As a merchant admin' do
  before(:each) do
    @meg = Merchant.create(name: "Meg's Bike Shop", address: '123 Bike Rd.', city: 'Denver', state: 'CO', zip: 80203)
    @tire = @meg.items.create(name: "Gatorskins", description: "They'll never pop!", price: 100, image: "https://www.rei.com/media/4e1f5b05-27ef-4267-bb9a-14e35935f218?size=784x588", inventory: 12)
    @chain = @meg.items.create(name: "Chain", description: "It'll never break!", price: 50, image: "https://www.rei.com/media/b61d1379-ec0e-4760-9247-57ef971af0ad?size=784x588", inventory: 5)
    @shifter = @meg.items.create(name: "Shimano Shifters", description: "It'll always shift!", active?: false, price: 180, image: "https://images-na.ssl-images-amazon.com/images/I/4142WWbN64L._SX466_.jpg", inventory: 2)
    @user = User.create(name: "Dee",
                        street_address: "4233 Street",
                        city: "Golden",
                        state: "CO",
                        zip: "80042",
                        email: "deedee@gmail.com",
                        password: "rainbows1908",
                        role: 3,
                        merchant_id: @meg.id)

    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@user)
  end

  describe 'When I visit my items page' do
    it "I see a button to edit an item" do
      visit '/merchant/items'

      within "#item-#{@tire.id}" do
        expect(page).to have_button 'Edit'
      end
    end

    it "When I click the edit item link, I see a form with prepopulated fields" do
      visit '/merchant/items'

      within "#item-#{@tire.id}" do
        click_button 'Edit' 
      end

      expect(current_path).to eq("/merchant/items/#{@tire.id}")
    end
  end

  describe 'When I submit valid edit information' do
    before(:each) do
      visit '/merchant/items'

      within "#item-#{@tire.id}" do
        click_button 'Edit' 
      end

      expect(current_path).to eq("/merchant/items/#{@tire.id}")
      
      fill_in 'Name', with: "Super Tire"
     
      click_button 'Update Item'
    end

    it "I am redirected to my items page" do
      expect(current_path).to eq('/merchant/items')
    end

    it "I see a flash message indicating succesful creation" do
      expect(page).to have_content("Super Tire has been updated!")
    end

    it "I see the item updated on the page" do
      within "#item-#{@tire.id}" do
        expect(page).to have_content("Super Tire")
      end
    end
  end

  describe 'When fields are blank or incorrectly filled in' do
    before(:each) do
      visit "/merchant/items"
      within "#item-#{@tire.id}" do  
        click_button 'Edit'
      end
    end

    it "If image is left blank, I see a placeholder image" do
      fill_in 'Image', with: ""

      click_button 'Update Item'

      within "#item-#{@tire.id}" do  
        expect(page).to have_css("img[src*='https://via.placeholder.com/36']")
      end
    end

    it "If price is less than or equal to zero, I see an error message" do
      fill_in 'Price', with: "-1"

      click_button 'Update Item'

      expect(page).to have_content("Price must be greater than 0")
    end

    it "If inventory is less than zero, I see an error message" do
      fill_in 'Inventory', with: '-1'

      click_button 'Update Item'

      expect(page).to have_content("Inventory must be greater than or equal to 0")
    end

    it "If any field other than image is blank, I see an error message" do
      fill_in 'Name', with: ""
      fill_in 'Price', with: ""
      fill_in 'Description', with: ""
      fill_in 'Inventory', with: ""

      click_button 'Update Item'

      expect(page).to have_content("Name can't be blank")
      expect(page).to have_content("Price can't be blank")
      expect(page).to have_content("Description can't be blank")
      expect(page).to have_content("Inventory can't be blank")
    end
  end
end
