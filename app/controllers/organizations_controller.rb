class OrganizationsController < ApplicationController
  before_action :auth_admin, only: [:index]

  def index
    @organizations = Organization.all
  end

  def show
    @organization = Organization.find_by subdomain: request.subdomain
  end

  private

  def auth_admin
    unless current_user_is_an_admin?
      redirect_back
    end
  end

  def current_user_is_an_admin?
    current_user.role == 'admin'
  end
end
