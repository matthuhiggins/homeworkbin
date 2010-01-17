class SessionsController < ApplicationController
  layout 'playground'
  
  def create
    if person = People.authenticate(params[:person])
      login person
    else
      flash[:notice] = "Incorrect e-mail/password"
    end
  end
end