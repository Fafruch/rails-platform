class OrganizationsController < ApplicationController
  before_action :authenticate_admin, only: [:index]

  def index
    @organizations = Organization.all
  end

  def show
    @organization = Organization.find(params[:id])
  end

  def show_by_domain
    @organization = Organization.find_by subdomain: request.subdomain
  end

  private

  def authenticate_admin
    unless current_user.admin?
      render file: 'public/403.html'
    end
  end
end
