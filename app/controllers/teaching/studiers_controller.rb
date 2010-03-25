class Teaching::StudiersController < Teaching::BaseController
  topic 'students'

  def index
    @studiers = current_course.studiers.all :include => :student, :order => 'people.full_name'
    @enrollments = current_course.enrollments.all
  end
  
  def show
    @studier = current_course.studiers.find params[:id]
    @assignments = current_course.assignments.scoped(:order => 'due_date desc, due_minutes desc')
  end
  
  def destroy
    @studier = current_course.studiers.find params[:id]
    @studier.destroy
    redirect_to teaching_studiers_path(current_course)
  end
end
