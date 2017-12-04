class UsersController < ApplicationController

  before_action :find_user
  before_action :authenticate_organization_admin

  def update
    if @user.update_attributes(user_params)
      redirect_to user_path(@user.id)
    else
      render :edit
    end
  end

  private

  def user_params
    params.require(:user).permit(:email, :phone_number, :first_name, :last_name)
  end

  def find_user
    @user ||= User.find(params[:id])
  end

  def authenticate_organization_admin
    return if @user == current_user

    render file: 'public/403.html' unless organization_admin_of_chosen_user?
  end

  def organization_admin_of_chosen_user?
    @common_organizations = current_user.organizations & @user.organizations
    @common_organizations.each do |organization|
      return true if current_user.user_organizations.find_by(organization_id: organization.id).organization_admin?
    end

    false
  end
end
