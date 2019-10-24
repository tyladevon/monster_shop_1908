require 'rails_helper'

describe "as a visitor who is not logged in" do
  before(:each) do
    visit '/login'
  end

  describe "when I visit the login path" do
    it "I see fields to enter my information" do
      expect(page).to have_field(:email)
      expect(page).to have_field(:password)
    end
  end

  describe "When I submit valid information" do
    it "if I am a regular user I am redirected to my profile page, and see a success message" do
      user = User.create(
        name: "Dee",
        street_address: "4233 Street",
        city: "Golden",
        state: "CO",
        zip: "80042",
        email: "deedee@gmail.com",
        password: "rainbows1908",
        role: 0
      )

      fill_in :email, with: "deedee@gmail.com"
      fill_in :password, with: "rainbows1908"
      click_button 'Login'

      expect(current_path).to eq('/profile')
      expect(page).to have_content("Welcome, #{user.name}!")
    end

    it "if I am a merchant user I am redirected to my merchant dashboard page, and see a success message" do
      user = User.create(
        name: "Bob G",
        street_address: "123 Avenue",
        city: "Portland",
        state: "OR",
        zip: "30203",
        email: "bobg@agency.com",
        password: "bobg",
        password_confirmation: "bobg",
        role: 2
      )

      fill_in :email, with: "bobg@agency.com"
      fill_in :password, with: "bobg"
      click_button 'Login'

      expect(current_path).to eq('/merchant/dashboard')
      expect(page).to have_content("Welcome, #{user.name}!")
    end

    it "if I am a admin user I am redirected to my admin dashboard page, and see a success message" do
      user = User.create(
        name: "Hillary",
        street_address: "234 Avenue",
        city: "Portland",
        state: "OR",
        zip: "30203",
        email: "hill@agency.com",
        password: "hill",
        password_confirmation: "hill",
        role: 1
      )

      fill_in :email, with: "hill@agency.com"
      fill_in :password, with: "hill"
      click_button 'Login'

      expect(current_path).to eq('/admin/dashboard')
      expect(page).to have_content("Welcome, #{user.name}!")
    end

    it "if I submit invaild information, I am redirected to the login page and I flash message" do
      user = User.create(
        name: "Hillary",
        street_address: "234 Avenue",
        city: "Portland",
        state: "OR",
        zip: "30203",
        email: "hill@agency.com",
        password: "hill",
        password_confirmation: "hill",
        role: 1
      )

      fill_in :email, with: "hill@agency.com"
      fill_in :password, with: "wrongpass"
      click_button 'Login'
      
      expect(current_path).to eq('/login')
      expect(page).to have_content("Email and password do not match.")
    end
  end
end
