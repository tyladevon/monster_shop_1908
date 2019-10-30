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
    it "I see a link to add a new item" do
      visit '/merchant/items'
      expect(page).to have_link 'Add New Item'
    end

    it "When I click the add item link, I see an information form" do
      visit '/merchant/items'
      click_link 'Add New Item'
      expect(current_path).to eq('/merchant/items/new')
    end
  end

  describe 'When I submit valid creation information' do
    before(:each) do
      visit '/merchant/items'
      click_link 'Add New Item'

      fill_in 'Name', with: "Bell"
      fill_in 'Price', with: 20
      fill_in 'Description', with: "Make your presence known"
      fill_in 'Image', with: "https://encrypted-tbn1.gstatic.com/shopping?q=tbn:ANd9GcRV7XE88aoycxTSkDDerfGeQokQPdPBboO8MaoXfg8Jwyx1-mbyd371GHlV51iUMVePzyT5n1Lj_8ThTym80aeF55fj0kmQCem6eV2UOYoL&usqp=CAc.jpg"
      fill_in 'Inventory', with: 3

      click_button 'Create Item'
    end
    it "I am redirected to my items page" do
      expect(current_path).to eq('/merchant/items')
    end

    it "I see a flash message indicating succesful creation" do
      expect(page).to have_content("Bell has been created!")
    end

    it "I see the new item on the page, and it is enabled" do
      expect(page).to have_content("Bell")
      expect(page).to have_content("Make your presence known")
      expect(page).to have_content("Price: $20")
      expect(page).to have_content("Inventory: 3")
      expect(page).to have_css("img[src*='shopping?q=tbn:ANd9GcRV7XE88aoycxTSkDDerfGeQokQPdPBboO8MaoXfg8Jwyx1-mbyd371GHlV51iUMVePzyT5n1Lj_8ThTym80aeF55fj0kmQCem6eV2UOYoL&usqp=CAc']")
      expect(page).to have_content('Active')
    end
  end

  describe 'When fields are blank or incorrectly filled in' do
    before(:each) do
      visit '/merchant/items/new'

    end

    it "If image is left blank, I see a placeholder image" do
      fill_in 'Name', with: "Bell"
      fill_in 'Price', with: 20
      fill_in 'Description', with: "Make your presence known"
      fill_in 'Inventory', with: 3

      click_button 'Create Item'
      expect(page).to have_css("img[src*='https://via.placeholder.com/36']")
    end

    it "If price is less than or equal to zero, I see an error message" do
      fill_in 'Name', with: "Bell"
      fill_in 'Price', with: "-1"
      fill_in 'Description', with: "Make your presence known"
      fill_in 'Inventory', with: 3

      click_button 'Create Item'

      expect(page).to have_content("Price must be greater than 0")
    end

    it "If inventory is less than zero, I see an error message" do
      fill_in 'Name', with: "Bell"
      fill_in 'Price', with: "20"
      fill_in 'Description', with: "Make your presence known"
      fill_in 'Inventory', with: '-1'

      click_button 'Create Item'

      expect(page).to have_content("Inventory must be greater than or equal to 0")
    end

    it "If any field other than image is blank, I see an error message" do
      click_button 'Create Item'

      expect(page).to have_content("Name can't be blank")
      expect(page).to have_content("Price can't be blank")
      expect(page).to have_content("Description can't be blank")
      expect(page).to have_content("Inventory can't be blank")
    end
  end
end
