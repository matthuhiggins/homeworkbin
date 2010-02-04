class Teaching::PeopleController < Teaching::BaseController
  require_login

  layout 'chalkboard'
  
  def show
  end
  
  def update
    if current_person.update_attributes params[:person]
      flash[:notice] = "Settings saved"
    end
    redirect_to :back
  end
  
  private
    def current_course
      nil
    end
end