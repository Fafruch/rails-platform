class HomeController < ApplicationController
  skip_before_action :authenticate_org_admin
end
