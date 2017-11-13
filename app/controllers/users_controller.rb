class UsersController < ApplicationController
  before_action :authenticate_user!
  protect_from_forgery prepend: true

  def new
    @user = User.new
  end
end
