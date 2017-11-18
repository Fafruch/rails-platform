module ApplicationHelper
  def is_current_user_an_admin?
    current_user.role == 'admin'
  end
end
