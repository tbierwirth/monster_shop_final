class User < ApplicationRecord
  has_secure_password

  belongs_to :merchant, optional: true
  has_many :addresses
  has_many :orders

  validates_presence_of :name,
                        :email

  validates_uniqueness_of :email

  enum role: ['default', 'merchant_admin', 'admin']

  def address_names
    addresses.pluck(:nickname)
  end

  def find_address(nickname)
    addresses.find_by(nickname: nickname)
  end
end
