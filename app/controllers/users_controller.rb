class UsersController < ApplicationController

  before_action :find_user
  before_action :authenticate_org_admin

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
    @user = User.find(params[:id])
  end

  def authenticate_org_admin
    return if @user.id == current_user.id

    @showed_user_organizations = UserOrganization.all.where(user_id: @user.id)
    @current_user_organizations = UserOrganization.all.where(user_id: current_user.id)
    @current_user_authorized = false

    @current_user_organizations.each do |current_user_organization|
      @showed_user_organizations.each do |chosen_user_organization|
        # check if user which we want to show / edit belongs to the same organization and if currently logged user
        # is admin of this organization
        next if current_user_organization.organization_id != chosen_user_organization.organization_id || !current_user_organization.org_admin?

        @current_user_authorized = true
      end
    end

    render file: 'public/403.html' unless @current_user_authorized
  end
end
