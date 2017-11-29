class UsersController < ApplicationController

  before_action :find_user
  before_action :authenticate_org_admin
  # before_action :find_organization

  def update
    if @user.update_attributes(user_params)
      # redirect_to organization_user_path(@organization.id, @user.id)
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
    @chosen_user_organizations = UserOrganization.all.where(user_id: @user.id)
    @current_user_organizations = UserOrganization.all.where(user_id: current_user.id)
    @current_user_authorized = false

    @current_user_organizations.each do |current_user_organization|
      @chosen_user_organizations.each do |chosen_user_organization|
        next if current_user_organization.organization_id != chosen_user_organization.organization_id || !current_user_organization.org_admin?

        @current_user_authorized = true
      end
    end

    render file: 'public/403.html' unless @current_user_authorized
  end

  # def find_organization
  #   @organization = Organization.find(params[:organization_id])
  # end
end
