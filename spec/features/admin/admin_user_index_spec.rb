require 'rails_helper'

describe 'As an admin user' do
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
      role: 0)
    @admin = User.create(
      name: "Profile Admin",
      street_address: "456 Ct",
      city: "Austin",
      state: "Texas",
      zip: "70289",
      email: "admin@gmail.com",
      password: "pass",
      password_confirmation: "pass",
      role: 1)

    @merch = User.create(
      name: "Profile Merch",
      street_address: "567 Ave",
      city: "Abeline",
      state: "Texas",
      zip: "39748",
      email: "merch@gmail.com",
      password: "pass",
      password_confirmation: "pass",
      role: 2)
  end

  it "Nav bar users link is only visible to admin" do
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@user)
    visit '/'
    within ".topnav" do
      expect(page).to_not have_link('Users')
    end

    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@merch)
    visit '/'
    within ".topnav" do
      expect(page).to_not have_link('Users')
    end

    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@admin)
    visit '/'
    within ".topnav" do
      expect(page).to have_link('Users')
    end
  end

  describe 'When I click the Users link in my nav bar' do
    it "My current URI is /admin/users" do
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@admin)
      visit '/'
      click_link 'Users'

      expect(current_path).to eq('/admin/users')
    end

    it "Other user types can't navigate to the admin users page" do
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@user)
      visit '/admin/users'
      expect(page).to have_content("404")

      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@merch)
      visit '/admin/users'
      expect(page).to have_content("404")
    end

    it "I see all users in the system, with name, date registered, and role" do
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@admin)
      visit '/admin/users'

      expect(page).to have_content(@user.name)
      expect(page).to have_content(@user.created_at)
      expect(page).to have_content("Role: Reg")

      expect(page).to have_content(@merch.name)
      expect(page).to have_content(@merch.created_at)
      expect(page).to have_content("Role: Merch_employee")

      expect(page).to have_content(@admin.name)
      expect(page).to have_content(@admin.created_at)
      expect(page).to have_content("Role: Admin")
    end
  end
end
