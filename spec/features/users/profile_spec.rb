require 'rails_helper'

describe 'As a registered user' do
  describe "when I visit my profile page" do
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
      @admin = User.create(
        name: "Profile Admin",
        street_address: "456 Ct",
        city: "Austin",
        state: "Texas",
        zip: "70289",
        email: "admin@gmail.com",
        password: "pass",
        password_confirmation: "pass",
        role: 1
      )

      @merch = User.create(
        name: "Profile Merch",
        street_address: "567 Ave",
        city: "Abeline",
        state: "Texas",
        zip: "39748",
        email: "merch@gmail.com",
        password: "pass",
        password_confirmation: "pass",
        role: 2
      )
    end

    it "I see all of my profile data except my password" do
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@user)
      visit '/profile'

      expect(page).to have_content(@user.name)
      expect(page).to have_content(@user.street_address)
      expect(page).to have_content(@user.city)
      expect(page).to have_content(@user.state)
      expect(page).to have_content(@user.zip)
      expect(page).to have_content(@user.email)
      expect(page).to_not have_content(@user.password)

      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@admin)
      visit '/profile'

      expect(page).to have_content(@admin.name)
      expect(page).to have_content(@admin.street_address)
      expect(page).to have_content(@admin.city)
      expect(page).to have_content(@admin.state)
      expect(page).to have_content(@admin.zip)
      expect(page).to have_content(@admin.email)
      expect(page).to_not have_content(@admin.password)

      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@merch)
      visit '/profile'

      expect(page).to have_content(@merch.name)
      expect(page).to have_content(@merch.street_address)
      expect(page).to have_content(@merch.city)
      expect(page).to have_content(@merch.state)
      expect(page).to have_content(@merch.zip)
      expect(page).to have_content(@merch.email)
      expect(page).to_not have_content(@merch.password)
    end

    it "I see a link to edit my profile data" do
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@user)
      visit '/profile'

      expect(page).to have_link('Edit Profile')

      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@merch)
      visit '/profile'

      expect(page).to have_link('Edit Profile')

      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@admin)
      visit '/profile'

      expect(page).to have_link('Edit Profile')
    end
  end
end
