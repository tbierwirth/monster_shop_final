require 'rails_helper'

RSpec.describe Address do
  describe 'Relationships' do
    it {should belong_to(:user)}
    it {should have_many(:orders)}
  end

  describe 'Validations' do
    it {should validate_presence_of :address}
    it {should validate_presence_of :city}
    it {should validate_presence_of :state}
    it {should validate_presence_of :zip}
    it {should validate_presence_of :nickname}
  end

  describe 'Class Mehods' do
    it '.shipped_orders?' do
      user = User.create!(name: 'Megan', email: 'megan_1@example.com', password: 'securepassword')
      address_1 = user.addresses.create(address: '123 Main St', city: 'Denver', state: 'CO', zip: 80218, nickname: 'Home')
      order_1 = user.orders.create!(status: "shipped", address_id: address_1.id)

      expect(address_1.shipped_orders?).to eq(true)
    end
  end
end
