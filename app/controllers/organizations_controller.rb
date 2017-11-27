class OrganizationsController < ApplicationController
  before_action :authenticate_org_admin, only: [:update]
  before_action :find_organization, only: %i[edit update show]

  skip_before_action :authenticate_user!, only: [:show_on_subdomain]

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

  def authenticate_admin
    unless current_user.org_admin?
      render file: 'public/403.html'
    end
  end

  def organization_params
    params.require(:organization).permit(:name, :subdomain)
  end

  # ????
  def find_organization
    @organization = Organization.find(params[:id])
  end
end
