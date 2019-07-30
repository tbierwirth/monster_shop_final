require 'rails_helper'

RSpec.describe "User Profile Path" do
  describe "As a registered user" do
    before :each do
      @megan = Merchant.create!(name: 'Megans Marmalades', address: '123 Main St', city: 'Denver', state: 'CO', zip: 80218)
      @ogre = @megan.items.create!(name: 'Ogre', description: "I'm an Ogre!", price: 20.25, image: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTaLM_vbg2Rh-mZ-B4t-RSU9AmSfEEq_SN9xPP_qrA2I6Ftq_D9Qw', active: true, inventory: 5 )
      @user = User.create!(name: 'Megan', email: 'megan@example.com', password: 'securepassword')
      @user_address_1 = @user.addresses.create(address: '123 Main St', city: 'Denver', state: 'CO', zip: 80218, nickname: 'Home')
      @user_address_2 = @user.addresses.create(address: '312 Rock St', city: 'Denver', state: 'CO', zip: 80218, nickname: 'Home')
      @order_1 = @user.orders.create!(status: "shipped", address_id: @user_address_1.id)
      @order_item_1 = @order_1.order_items.create!(item: @ogre, price: @ogre.price, quantity: 2, fulfilled: true)
      visit login_path
      fill_in 'Email', with: @user.email
      fill_in 'Password', with: @user.password
      click_button 'Log In'
    end

    it "I can edit an address" do
      visit profile_path

      within "#address-#{@user_address_2.id}" do
        click_on 'Edit Address'
      end

      fill_in 'Address', with: '321 New St'
      fill_in 'City', with: 'Aurora'
      fill_in 'Zip', with: '80012'
      fill_in 'Nickname', with: 'Work'

      click_on 'Update Address'

      expect(current_path).to eq(profile_path)
      within "#address-#{@user_address_2.id}" do
        @user_address_2.reload
        expect(page).to have_content("321 New St")
        expect(page).to have_content("Aurora")
        expect(page).to have_content("80012")
        expect(page).to have_content("Work")
      end
    end

    it 'I can not edit an address if there is a shipped order on it' do
      visit profile_path

      within "#address-#{@user_address_1.id}" do
        expect(page).to_not have_link('Edit Address')
      end
    end

  end
end
