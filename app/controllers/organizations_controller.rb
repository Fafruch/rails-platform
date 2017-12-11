class OrganizationsController < ApplicationController
  before_action :authenticate_organization_admin, only: %i[edit update]
  before_action :find_organization, only: %i[show edit update]

  skip_before_action :authenticate_user!, only: [:show_on_subdomain]

  def index
    @organizations = current_user.organizations
    @user_organizations = current_user.user_organizations
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

  def authenticate_organization_admin
    render file: 'public/403.html' unless admin_role_for_organization?
  end

  def admin_role_for_organization?
    current_user.user_organizations.exists?(organization_role: 'organization_admin', organization_id: params[:id])
  end

  def organization_params
    params.require(:organization).permit(:name, :subdomain)
  end

  def find_organization
    @organization ||= Organization.find(params[:id])
  end
end
