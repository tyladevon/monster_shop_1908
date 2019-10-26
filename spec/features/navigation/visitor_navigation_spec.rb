require 'rails_helper'

describe 'as a visitor who is not logged in' do
  it "I get a 404 error when trying to view my profile page" do
    visit '/profile'

    expect(page).to have_content("The page you were looking for doesn't exist")
  end

  it "I get a 404 error when trying to access merchant user pages" do
    visit '/merchant'

    expect(page).to have_content("The page you were looking for doesn't exist")
  end

  it "I get a 404 error when trying to access admin pages" do
    visit '/admin'

    expect(page).to have_content("The page you were looking for doesn't exist")
  end
end
