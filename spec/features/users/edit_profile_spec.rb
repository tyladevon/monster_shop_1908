require 'rails_helper'

describe 'as a registered user' do
  describe 'when I visit my profile page and click the edit link' do
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
    it "I am redirected to a form like the registration page" do
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@user)
      visit '/profile'
      click_link 'Edit Profile'

      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@admin)
      visit '/profile'
      click_link 'Edit Profile'

      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@merch)
      visit '/profile'
      click_link 'Edit Profile'

      expect(current_path).to eq("/profile/edit")
    end

    it "I see a form prepopulated with my info except my password " do
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@user)
      visit '/profile/edit'

      expect(find_field(:name).value).to eq("Profile User")
      expect(find_field(:street_address).value).to eq("345 Blvd")
      expect(find_field(:city).value).to eq("San Antonio")
      expect(find_field(:state).value).to eq("Texas")
      expect(find_field(:zip).value).to eq("60789")
      expect(find_field(:email).value).to eq("profile@gmail.com")

      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@admin)
      visit '/profile/edit'

      expect(find_field(:name).value).to eq("Profile Admin")
      expect(find_field(:street_address).value).to eq("456 Ct")
      expect(find_field(:city).value).to eq("Austin")
      expect(find_field(:state).value).to eq("Texas")
      expect(find_field(:zip).value).to eq("70289")
      expect(find_field(:email).value).to eq("admin@gmail.com")

      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@merch)
      visit '/profile/edit'

      expect(find_field(:name).value).to eq("Profile Merch")
      expect(find_field(:street_address).value).to eq("567 Ave")
      expect(find_field(:city).value).to eq("Abeline")
      expect(find_field(:state).value).to eq("Texas")
      expect(find_field(:zip).value).to eq("39748")
      expect(find_field(:email).value).to eq("merch@gmail.com")
    end

    it "When I submit new information, my information is updated" do
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@user)
      visit '/profile/edit'

      fill_in :name, with: "Reggie"
      fill_in :street_address, with: "345 Street"
      fill_in :city, with: "El Paso"
      fill_in :state, with: "Texas"
      fill_in :zip, with: "11111"
      fill_in :email, with: "reggie@gmail.com"

      click_button 'Update Information'

      expect(page).to have_content("Your information has been updated!")

      expect(current_path).to eq('/profile')

      expect(page).to have_content('Reggie')
      expect(page).to have_content('345 Street')
      expect(page).to have_content('El Paso')
      expect(page).to have_content('Texas')
      expect(page).to have_content('11111')
      expect(page).to have_content('reggie@gmail.com')

      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@admin)
      visit '/profile/edit'

      fill_in :name, with: "Boss"
      fill_in :street_address, with: "345 Avenue"
      fill_in :city, with: "Lubbock"
      fill_in :state, with: "Texas"
      fill_in :zip, with: "22222"
      fill_in :email, with: "boss@gmail.com"

      click_button 'Update Information'

      expect(page).to have_content("Your information has been updated!")

      expect(current_path).to eq('/profile')

      expect(page).to have_content('Boss')
      expect(page).to have_content('345 Avenue')
      expect(page).to have_content('Lubbock')
      expect(page).to have_content('Texas')
      expect(page).to have_content('22222')
      expect(page).to have_content('boss@gmail.com')

      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@merch)
      visit '/profile/edit'

      fill_in :name, with: "Merchant"
      fill_in :street_address, with: "432 Circle"
      fill_in :city, with: "Fort Worth"
      fill_in :state, with: "Texas"
      fill_in :zip, with: "33333"
      fill_in :email, with: "merchant@gmail.com"

      click_button 'Update Information'

      expect(page).to have_content("Your information has been updated!")

      expect(current_path).to eq('/profile')

      expect(page).to have_content('Merchant')
      expect(page).to have_content('432 Circle')
      expect(page).to have_content('Fort Worth')
      expect(page).to have_content('Texas')
      expect(page).to have_content('33333')
      expect(page).to have_content('merchant@gmail.com')
    end

    it "I can't change my email address to one belonging to another user" do
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@user)

      visit '/profile/edit'

      fill_in :email, with: "admin@gmail.com"

      click_button 'Update Information'

      expect(page).to have_content('Email has already been taken')
    end
  end
end
