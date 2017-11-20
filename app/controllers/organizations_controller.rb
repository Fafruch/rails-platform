class OrganizationsController < ApplicationController
  before_action :authenticate_admin, only: [:index]
  skip_before_action :authenticate_user!, only: [:show_on_subdomain]

  def index
    @organizations = Organization.all
  end

  def show
    @organization = Organization.find(params[:id])
  end

  def show_on_subdomain
    @organization = Organization.find_by subdomain: request.subdomain
    render :show
  end

  private

  def authenticate_admin
    unless current_user.admin?
      render file: 'public/403.html'
    end
  end
end
