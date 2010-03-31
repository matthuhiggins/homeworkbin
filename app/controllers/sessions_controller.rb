class SessionsController < ApplicationController
  def create
    if person = Person.authenticate(params[:email], params[:password])
      login person, :remember => params[:remember_me].present?
    else
      flash[:warning] = 'Incorrect e-mail/password'
      render 'new'
    end
  end

  def destroy
    terminate_authenticated_session
    redirect_to root_path
  end
end
