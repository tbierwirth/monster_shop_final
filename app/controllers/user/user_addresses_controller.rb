class User::UserAddressesController < ApplicationController
  def new
    @address = UserAddress.new
  end

  def create

  end
end
