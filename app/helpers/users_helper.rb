module UsersHelper
  def is_it_myself?
    current_user.id == @user.id
  end
end
