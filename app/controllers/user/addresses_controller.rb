class User::AddressesController < ApplicationController
  def new
    @address = Address.new
  end

  def create
    @user = current_user
    @address = @user.addresses.new(address_params)
    if @address.save
      redirect_to profile_path
      flash[:notice] = "A new address has been added to your profile"
    else
      generate_flash(@address)
    end
  end

  private
  def address_params
    params.require(:address).permit(:address, :city, :state, :zip, :alias)
  end
end
