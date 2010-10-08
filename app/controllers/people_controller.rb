class PeopleController < ApplicationController
  require_login
  shows_sub_menu 'people'

  def show
  end
  
  def update
    if current_person.update_attributes params[:person]
      flash[:notice] = 'Settings saved'
    end
    redirect_to :back
  end
end