require 'rails_helper'

RSpec.describe 'merchant new page', type: :feature do
  describe 'As a user' do
    it 'I cannot see a link create a new merchant' do
      visit '/merchants'

      expect(page).to_not have_link('Create Merchant')
    end
  end
end
