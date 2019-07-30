require 'rails_helper'

RSpec.describe "User Profile Path" do
  describe "As a registered user" do
    before :each do
      @user = User.create!(name: 'Megan', email: 'megan@example.com', password: 'securepassword')
      @user_address_1 = @user.addresses.create(address: '123 Main St', city: 'Denver', state: 'CO', zip: 80218, alias: 'Home')
      @user_address_2 = @user.addresses.create(address: '321 Rocky Rd', city: 'Castle Rock', state: 'CO', zip: 80109, alias: 'Work')
      visit login_path
      fill_in 'Email', with: @user.email
      fill_in 'Password', with: @user.password
      click_button 'Log In'
    end

    it "I can delete an address from my user profile" do
      visit profile_path

      within "#address-#{@user_address_2.id}" do
        click_on 'Delete Address'
      end

      expect(current_path).to eq(profile_path)
      expect(page).to_not have_content(@user_address_2.address)
    end

  end
end
