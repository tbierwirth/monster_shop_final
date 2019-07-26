class UserAddress < ApplicationRecord
  belongs_to :user

  validates_presence_of :address,
                        :city,
                        :state,
                        :zip,
                        :alias

end
