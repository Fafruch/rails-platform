class OrganizationsController < ApplicationController
  def show
    @organization = Organization.find_by subdomain: request.subdomain
  end
end
