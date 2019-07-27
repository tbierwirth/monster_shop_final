class UsersController < ApplicationController
  before_action :require_user, only: :show
  before_action :exclude_admin, only: :show

  def show
    @user = current_user
  end

  def new
    @user = User.new
    @user_addresses = @user.user_addresses.new
  end

  def create
    @user = User.new(user_params)
    @user.user_addresses.new(address_params[:user_addresses_attributes]['0'])
    if @user.save
      session[:user_id] = @user.id
      flash[:notice] = "Welcome, #{@user.name}!"
      redirect_to profile_path
    else
      generate_flash(@user)
      render :new
    end
  end

  def edit
    @user = current_user
  end

  def edit_password
    @user = current_user
  end

  def update
    @user = current_user
    if @user.update(user_params)
      flash[:notice] = 'Profile has been updated!'
      redirect_to profile_path
    else
      generate_flash(@user)
      render :edit
    end
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :password)
    # params.require(user: :user_addresses).permit(:address, :city, :state, :zip)
  end

  def address_params
    params.require(:user).permit(user_addresses_attributes: [:address, :city, :state, :zip, :alias])
  end
end
