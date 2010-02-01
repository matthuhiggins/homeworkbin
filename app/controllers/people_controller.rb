class PeopleController < ApplicationController
  require_login

  layout 'classroom'
  
  def show
  end
  
  def update
    if current_person.update_attributes params[:person]
      flash[:notice] = "Settings saved"
    end
    redirect_to :back
  end
end