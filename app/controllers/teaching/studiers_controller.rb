class Teaching::StudiersController < Teaching::BaseController
  def index
    @studiers = current_course.studiers.all
    @enrollments = current_course.enrollments.all
  end
  
  def show
    @studier = current_course.studiers.find params[:id]
  end
  
  def destroy
    @studier = current_course.studiers.find params[:id]
    @studier.destroy
    redirect_to teaching_studiers_path(current_course)
  end
end
