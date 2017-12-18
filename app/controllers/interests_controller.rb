class InterestsController < ApplicationController
  before_action :authenticate_organization_admin
  before_action :find_interest


end
