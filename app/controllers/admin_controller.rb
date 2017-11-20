class AdminController < ApplicationController
  before_action :authenticate_user!
  protect_from_forgery prepend: true

  before_action :auth_admin

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
