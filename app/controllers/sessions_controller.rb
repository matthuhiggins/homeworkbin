class SessionsController < ApplicationController
  layout 'marketing'
  
  def create
    if person = People.authenticate(params[:person])
      login person
    else
      flash[:notice] = "Incorrect e-mail/password"
    end
  end
end