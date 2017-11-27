class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :authenticate_user!
  before_action :authenticate_org_admin

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:first_name, :last_name, :email, :phone_number, :password, :password_confirmation])
  end

  def authenticate_org_admin
    unless current_user.org_admin?
      render file: 'public/403.html'
    end
  end
end
