class UserOrganizationsController < ApplicationController
  before_action :authenticate_org_admin
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

  def authenticate_org_admin
    @current_user_organization = UserOrganization.find_by(user_id: current_user.id, organization_id: params[:organization_id])
    @is_not_admin_of_current_org = true

    if @current_user_organization.present?
      @is_not_admin_of_current_org = @current_user_organization.member?
    end

    render file: 'public/403.html' if @is_not_admin_of_current_org
  end

  def user_organization_params
    params.require(:user_organization).permit(:organization_role)
  end

  def find_user
    @user = User.find(params[:id])
  end

  def find_user_organization
    @user_organization = UserOrganization.find_by(user_id: params[:id], organization_id: params[:organization_id])
  end
end
