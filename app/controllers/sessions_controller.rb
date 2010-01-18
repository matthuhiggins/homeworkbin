class SessionsController < ApplicationController
  layout 'playground'
  
  def create
    if person = Person.authenticate(params[:email], params[:password])
      login person, params[:remember_me].present?
    else
      flash[:notice] = "Incorrect e-mail/password"
      flash[:email_attempt] = params[:email]
      redirect_to login_path
    end
  end
  
  def destroy
    terminate_authenticated_session
    redirect_to root_path
  end
end
