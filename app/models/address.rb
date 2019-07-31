class Address < ApplicationRecord
  belongs_to :user
  has_many :orders

  validates_presence_of :address,
                        :city,
                        :state,
                        :zip,
                        :nickname

  validates :nickname, uniqueness: { scope: :user_id }
  def shipped_orders?
    orders.where(status: 'shipped').exists?
  end
end
