class Teaching::EnrollmentsController < Teaching::BaseController
  shows_topic 'students'

  def index
    @enrollments = current_course.enrollments
  end

  def create
    current_course.enrollments.matriculate_emails params[:emails]
    redirect_to teaching_studiers_path(current_course), notice: 'Students were e-mailed'
  end
  
  def destroy
    @enrollment = current_course.enrollments.find_by_token params[:id]
    @enrollment.destroy
    redirect_to teaching_enrollments_path(current_course)
  end
end