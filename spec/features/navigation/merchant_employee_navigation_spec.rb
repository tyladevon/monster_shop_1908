require 'rails_helper'

describe 'As a merchant employee user' do
  before(:each) do
    @user = User.create(name: "Bob G",
                        street_address: "123 Avenue",
                        city: "Portland",
                        state: "OR",
                        zip: "30203",
                        email: "bobg@agency.com",
                        password: "bobg",
                        password_confirmation: "bobg",
                        role: 2
                        )

    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@user)
    visit '/'
  end
  it "can see regular logged in links" do
    expect(page).to have_link "All Items"
    expect(page).to have_link "All Merchants"
    expect(page).to have_link "Home"
    expect(page).to have_content("Cart")
    expect(page).to have_link "Profile"
    expect(page).to have_link "Logout"
  end

  it "can see link to merchant dashboard" do
    expect(page).to have_link 'Dashboard'
  end
end
