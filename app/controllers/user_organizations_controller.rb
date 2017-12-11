class UserOrganizationsController < ApplicationController
  before_action :authenticate_organization_admin
  before_action :find_user_organization
  before_action :find_user, only: [:edit]

  def update
    if @user_organization.update_attributes(user_organization_params)
      redirect_to organizations_path
    else
      render :edit
    end
  end

  def destroy
    @user_organization.destroy

    redirect_to organizations_path
  end


  private

  def authenticate_organization_admin
    render file: 'public/403.html' unless admin_role_for_organization?
  end

  def admin_role_for_organization?
    current_user.user_organizations.exists?(organization_role: 'organization_admin', organization_id: params[:organization_id])
  end

  def user_organization_params
    params.require(:user_organization).permit(:organization_role)
  end

  def find_user
    @user ||= User.find(params[:id])
  end

  def find_user_organization
    @user_organization ||= UserOrganization.find_by(user_id: params[:id], organization_id: params[:organization_id])
  end
end
