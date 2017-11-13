class UsersController < ApplicationController
  before_action :authenticate_user!
  protect_from_forgery prepend: true

  def new
    @user = User.new
  end

  def show
    @user = User.find(params[:id])
  end

  def edit
    @user = User.find(params[:id])
  end
end
