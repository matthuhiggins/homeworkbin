class PeopleController < ApplicationController
  require_login
  shows_sub_menu 'people'

  def show
  end

  def update
    if current_person.update_attributes params[:person]
      redirect_to settings_path, notice: 'Settings saved'
    else
      render 'show'
    end
  end

  def password
    if request.put? && current_person.update_attributes(params[:person])
      redirect_to settings_path, notice: 'Password updated'
    end
  end
end