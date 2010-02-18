class Teaching::EnrollmentsController < Teaching::BaseController
  topic 'students'

  def index
    @enrollments = current_course.enrollments
  end

  def create
    current_course.enrollments.matriculate_emails params[:emails]
    flash[:notice] = "Good work"
    redirect_to teaching_studiers_path(current_course)
  end
  
  def destroy
    @enrollment = current_course.enrollments.find_by_token params[:id]
    @enrollment.destroy
    redirect_to teaching_enrollments_path(current_course)
  end
end