module SessionsHelper
  def email_login_value
    params[:email] || cookies[:last_email]
  end
  
  def logout
    link_to 'Logout', logout_path, :method => :delete
  end
end