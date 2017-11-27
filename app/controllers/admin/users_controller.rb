class Admin::UsersController < Admin::BaseController

  before_action :find_user, only: %i[show edit update destroy]

  def index
    @users = User.all
  end

  def new
    @user = User.new
  end

  def update
    if @user.update_attributes(user_params)
      redirect_to @user
    else
      render :edit
    end
  end

  def destroy
    if @user.is_same_as(current_user)
      flash[:warning] = 'Don\'t remove yourself! ;)'
      render :show
    else
      @user.destroy
      render :index
    end
  end

  private

  def user_params
    params.require(:user).permit(:email, :phone_number, :first_name, :last_name, :role)
  end

  def find_user
    @user = User.find(params[:id])
  end
end
