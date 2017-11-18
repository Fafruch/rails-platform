module ApplicationHelper
  def current_user_is_an_admin?
    current_user.role == 'admin'
  end
end
