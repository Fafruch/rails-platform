class Admin::BaseController < ApplicationController
  protect_from_forgery prepend: true

  before_action :authenticate_global_admin

  private

  def authenticate_global_admin
    render file: 'public/403.html' unless current_user.global_admin?
  end
end
