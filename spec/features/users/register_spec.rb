require 'rails_helper'

RSpec.describe "Visitor Registration" do
  before(:each) do
    visit '/'
    click_link "Register"
  end

  it "can register" do
    expect(current_path).to eq("/register")

    fill_in :name, with: "Bob G"
    fill_in :street_address, with: "5345 Address"
    fill_in :city, with: "Denver"
    fill_in :state, with: "CO"
    fill_in :zip, with: "80210"
    fill_in :email, with: "bobg@gmail.com"
    fill_in :password, with: "bobg121!"
    fill_in :password_confirmation, with: "bobg121!"

    click_button "Submit"
    expect(current_path).to eq("/profile")
    expect(page).to have_content("You are now registered and logged in!")
  end

  it "cannot register with missing details" do

    click_button "Submit"

    # expect(current_path).to eq('/register')
    expect(page).to have_content("Name can't be blank, Street address can't be blank, City can't be blank, State can't be blank, Zip can't be blank, Password can't be blank, and Email can't be blank")
  end

  it "cannot register with mismatched password and password confirmation" do

    fill_in :name, with: "Bob G"
    fill_in :street_address, with: "5345 Address"
    fill_in :city, with: "Denver"
    fill_in :state, with: "CO"
    fill_in :zip, with: "80210"
    fill_in :email, with: "bobg@gmail.com"
    fill_in :password, with: "bobg121!"
    fill_in :password_confirmation, with: "bobg121"

    click_button 'Submit'

    # expect(current_path).to eq('/register')
    expect(page).to have_content("Password confirmation doesn't match Password")
  end

  it "cannot register with an existing email address" do
    User.create!(name:"Ryan", street_address: "123 Street", city: "Denver", state: "CO", zip: "80202", email: "rhantak@gmail.com", password: "pass", password_confirmation: "pass")

    fill_in :name, with: "Bob G"
    fill_in :street_address, with: "5345 Address"
    fill_in :city, with: "Denver"
    fill_in :state, with: "CO"
    fill_in :zip, with: "80210"
    fill_in :email, with: "rhantak@gmail.com"
    fill_in :password, with: "bobg121!"
    fill_in :password_confirmation, with: "bobg121!"

    click_button 'Submit'

    # expect(current_path).to eq('/register')
    expect(find_field(:name).value).to eq("Bob G")
    expect(find_field(:street_address).value).to eq("5345 Address")
    expect(find_field(:city).value).to eq("Denver")
    expect(find_field(:state).value).to eq("CO")
    expect(find_field(:zip).value).to eq("80210")
    expect(find_field(:email).value).to eq(nil)
    expect(find_field(:password).value).to eq(nil)
    expect(find_field(:password_confirmation).value).to eq(nil)
    expect(page).to have_content("Email has already been taken")

  end
end
