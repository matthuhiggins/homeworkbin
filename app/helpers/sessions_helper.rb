module SessionsHelper
  def email_login_value
    params[:email] || cookies[:last_login]
  end
  
  def link_to_logout
    link_to 'Logout', logout_path, method: :delete
  end
end