require 'rails_helper'

RSpec.describe User do
  describe 'Relationships' do
    it {should belong_to(:merchant).optional}
    it {should have_many :orders}
    it {should have_many :addresses}
  end

  describe 'Validations' do
    it {should validate_presence_of :name}
    it {should validate_presence_of :email}
    it {should validate_uniqueness_of :email}
  end

  describe 'Class Methods' do
    before :each do
      @user = User.create!(name: 'Megan', email: 'megan@example.com', password: 'securepassword')
      @address_1 = @user.addresses.create(address: '123 Main St', city: 'Denver', state: 'CO', zip: 80218, nickname: 'Home')
      @address_2 = @user.addresses.create(address: '321 Rocky Rd', city: 'Aurora', state: 'CO', zip: 80012, nickname: 'Work')
    end
    it '.address_names' do
      expect(@user.address_names).to eq([@address_1.nickname, @address_2.nickname])
    end

    it '.find_address(nickname)' do
      nickname = "Work"
      expect(@user.find_address(nickname)).to eq(@address_2)
    end

  end
end
