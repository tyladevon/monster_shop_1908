require 'rails_helper'

RSpec.describe "As any kind of user on the system" do
  describe "When I visit the items index page" do
    before(:each) do

      visit "/items"
    end
    it "I see an area with statistics" do
      expect(page).to have_content("Statistics")

      within "#statistics-" do
        expect(page).to have_content("Top 5 Most Popular Items")
        expect(page).to have_content("Least Popular Items--bottom 5")
      end
    end

  end
end
