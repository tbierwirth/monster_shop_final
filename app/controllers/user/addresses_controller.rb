class User::AddressesController < ApplicationController
  def new
    @address = Address.new
  end

  def edit
    @address = Address.find(params[:id])
  end

  def create
    @user = current_user
    @address = @user.addresses.new(address_params)
    if @address.save
      redirect_to profile_path
      flash[:notice] = "A new address has been added to your profile"
    else
      generate_flash(@address)
      render :new
    end
  end

  def update
    @address = Address.find(params[:id])
    if @address.update(address_params)
      flash[:notice] = 'Address has been updated!'
      redirect_to profile_path
    else
      generate_flash(@address)
      render :edit
    end
  end

  def destroy
    @address = Address.find(params[:id])
    @address.delete
    flash[:notice] = 'Address has been deleted.'
    redirect_to profile_path
  end

  private
  def address_params
    params.require(:address).permit(:address, :city, :state, :zip, :nickname)
  end
end
