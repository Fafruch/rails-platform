class UsersController < ApplicationController
  before_action :authenticate_user!
  protect_from_forgery prepend: true

  def new
    @user = User.new
  end

  def show
    @user = User.find(params[:id])
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])

    if @user.update_attributes(user_params)
      redirect_to @user
    else
      render :edit
    end
  end

  private

  def user_params
    params.require(:user).permit(:email, :phone_number, :first_name, :last_name)
  end
end
