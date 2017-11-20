class AdminController < ApplicationController
  protect_from_forgery prepend: true

  before_action :authenticate_admin

  private

  def authenticate_admin
    unless current_user.admin?
      render file: 'public/403.html'
    end
  end
end
