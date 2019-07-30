require 'rails_helper'

RSpec.describe "User Profile Path" do
  describe "As a registered user" do
    before :each do
      @user = User.create!(name: 'Megan', email: 'megan@example.com', password: 'securepassword')
      @user_address = @user.addresses.create(address: '123 Main St', city: 'Denver', state: 'CO', zip: 80218, nickname: 'Home')
    end

    it "I can add a new address to my profile" do
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@user)
      visit profile_path
      click_on 'New Address'

      expect(current_path).to eq(new_user_address_path)
      fill_in "Address", with: '321 Work St'
      fill_in "City", with: 'Aurora'
      fill_in "State", with: 'CO'
      fill_in "Zip", with: '80012'
      fill_in "nickname", with: 'Work'

      click_on 'Create Address'

      expect(current_path).to eq(profile_path)
      expect(page).to have_content('123 Main St')
      expect(page).to have_content('Denver')
      expect(page).to have_content('CO')
      expect(page).to have_content('80218')
      expect(page).to have_content('Home')

      expect(page).to have_content('321 Work St')
      expect(page).to have_content('Aurora')
      expect(page).to have_content('CO')
      expect(page).to have_content('80012')
      expect(page).to have_content('Work')
    end

    it "I can't add a new address to my profile with incorrect info" do
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@user)
      visit profile_path
      click_on 'New Address'

      expect(current_path).to eq(new_user_address_path)

      fill_in "Address", with: '321 Work St'
      click_on 'Create Address'

      expect(page).to have_content("city: [\"can't be blank\"]")
      expect(page).to have_content("state: [\"can't be blank\"]")
      expect(page).to have_content("zip: [\"can't be blank\"]")

    end
  end
end
