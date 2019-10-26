require 'rails_helper'

RSpec.describe "Sessions New" do
  it "As a reg user, I am redirected to /profile if logged in" do
    user = User.create(
      name: "Bob G",
      street_address: "123 Avenue",
      city: "Portland",
      state: "OR",
      zip: "30203",
      email: "bobg@agency.com",
      password: "bobg",
      password_confirmation: "bobg",
    )
    visit '/login'
    fill_in :email, with: "bobg@agency.com"
    fill_in :password, with: "bobg"
    click_button 'Login'

    expect(current_path).to eq('/profile')

    visit '/login'

    expect(current_path).to eq('/profile')
    expect(page).to have_content("You are already logged in #{user.name}")
  end

  it "As a admin, I am redirected to /admin if logged in" do
    user = User.create(
      name: "Bob G",
      street_address: "123 Avenue",
      city: "Portland",
      state: "OR",
      zip: "30203",
      email: "bobg1@agency.com",
      password: "bobg",
      password_confirmation: "bobg",
      role: 1
    )

    visit '/login'
    fill_in :email, with: "bobg1@agency.com"
    fill_in :password, with: "bobg"
    click_button 'Login'

    expect(current_path).to eq('/admin')

    visit '/login'

    expect(current_path).to eq('/admin')
    expect(page).to have_content("You are already logged in #{user.name}")
  end

  it "As a merchant employee or admin, I am redirected to /merchant/admin if logged in" do
    meg = Merchant.create(name: "Meg's Bike Shop", address: '123 Bike Rd.', city: 'Denver', state: 'CO', zip: 80203)

    user = User.create(
      name: "Bob G",
      street_address: "123 Avenue",
      city: "Portland",
      state: "OR",
      zip: "30203",
      email: "bobg2@agency.com",
      password: "bobg",
      password_confirmation: "bobg",
      role: 2,
      merchant_id: meg.id
    )

    visit '/login'
    fill_in :email, with: "bobg2@agency.com"
    fill_in :password, with: "bobg"
    click_button 'Login'

    expect(current_path).to eq('/merchant')

    visit '/login'

    expect(current_path).to eq('/merchant')
    expect(page).to have_content("You are already logged in #{user.name}")
  end
end
