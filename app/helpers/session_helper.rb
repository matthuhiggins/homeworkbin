module SessionHelper
  def email_login_value
    params[:email] || cookies[:last_email]
  end
end