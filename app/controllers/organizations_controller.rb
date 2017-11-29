class OrganizationsController < ApplicationController
  before_action :authenticate_org_admin, only: %i[edit update]
  before_action :find_organization, only: %i[show edit update]

  skip_before_action :authenticate_user!, only: [:show_on_subdomain]

  def index
    @organizations = current_user.organizations
    @user_organizations = UserOrganization.all.where(user_id: current_user.id)
  end

  def update
    if @organization.update_attributes(organization_params)
      redirect_to action: 'index'
    else
      render :edit
    end
  end

  def show_on_subdomain
    @organization = Organization.find_by subdomain: request.subdomain
    render :show
  end


  private

  def authenticate_org_admin
    @is_not_admin_of_current_org = true
    @current_user_organization = UserOrganization.find_by(user_id: current_user.id, organization_id: params[:id])

    if @user_organization.present?
      @is_not_admin_of_current_org = @current_user_organization.member?
    end

    render file: 'public/403.html' if @is_not_admin_of_current_org
  end

  def organization_params
    params.require(:organization).permit(:name, :subdomain)
  end

  def find_organization
    @organization = Organization.find(params[:id])
  end
end
