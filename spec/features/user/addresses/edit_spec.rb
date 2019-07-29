require 'rails_helper'

RSpec.describe "User Profile Path" do
  describe "As a registered user" do
    before :each do
      @user = User.create!(name: 'Megan', email: 'megan@example.com', password: 'securepassword')
      @user_address = @user.addresses.create(address: '123 Main St', city: 'Denver', state: 'CO', zip: 80218, alias: 'Home')
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@user)
    end

    it "I can edit an address" do
      visit profile_path

      within "#address-#{@user_address.id}" do
        click_on 'Edit Address'
      end

      fill_in 'Address', with: '321 New St'
      fill_in 'City', with: 'Aurora'
      fill_in 'Zip', with: '80012'
      fill_in 'Alias', with: 'Work'

      click_on 'Update Address'

      expect(current_path).to eq(profile_path)
      within "#address-#{@user_address.id}" do
        expect(page).to have_content("321 New St")
        expect(page).to have_content("Aurora")
        expect(page).to have_content("80012")
        expect(page).to have_content("Work")
      end
    end

  end
end
