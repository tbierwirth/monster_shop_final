require 'rails_helper'

RSpec.describe "User Profile Path" do
  describe "As a registered user" do
    before :each do
      @user = User.create!(name: 'Megan', email: 'megan@example.com', password: 'securepassword')
      @user_address = @user.addresses.create(address: '123 Main St', city: 'Denver', state: 'CO', zip: 80218, nickname: 'Home')
      visit login_path
      fill_in 'Email', with: @user.email
      fill_in 'Password', with: @user.password
      click_button 'Log In'
    end

    it "I can edit an address" do
      visit profile_path

      within "#address-#{@user_address.id}" do
        click_on 'Edit Address'
      end

      fill_in 'Address', with: '321 New St'
      fill_in 'City', with: 'Aurora'
      fill_in 'Zip', with: '80012'
      fill_in 'nickname', with: 'Work'

      click_on 'Update Address'

      expect(current_path).to eq(profile_path)
      within "#address-#{@user_address.id}" do
        @user_address.reload
        expect(page).to have_content("321 New St")
        expect(page).to have_content("Aurora")
        expect(page).to have_content("80012")
        expect(page).to have_content("Work")
      end
    end

  end
end
