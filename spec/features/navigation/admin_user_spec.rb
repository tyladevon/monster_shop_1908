require 'rails_helper'

RSpec.describe "As an Admin User" do
  before(:each) do
    @admin_user = User.create(name: "Bob G",
                        street_address: "123 Avenue",
                        city: "Portland",
                        state: "OR",
                        zip: "30203",
                        email: "bobg@agency.com",
                        password: "bobg",
                        password_confirmation: "bobg",
                        role: 1
                        )

  allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@admin_user)
  visit '/'
end

  it "can see links just as regular user" do
    expect(page).to have_link "All Items"
    expect(page).to have_link "All Merchants"
    expect(page).to have_link "Home"
    expect(page).to have_link "Profile"
    expect(page).to have_link "Logout"
  end

  it "can see admin links" do
    expect(page).to have_link "Admin Dashboard"
    expect(page).to have_link "All Users"

  end

  it "cannot see link for shopping cart" do
    expect(page).to_not have_content("Cart")
  end

  it "cannot access merchant or cart path" do
    visit "/merchant"
    expect(page).to have_content("The page you were looking for doesn't exist.")
    
    visit "/cart"
    expect(page).to have_content("The page you were looking for doesn't exist.")
  end
end
