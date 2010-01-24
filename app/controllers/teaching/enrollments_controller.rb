class Teaching::EnrollmentsController < Teaching::BaseController
  def index
    @enrollments = current_course.enrollments
  end

  def create
    current_course.enrollments.matriculate_emails params[:emails]
    flash[:notice] = "Good work"
    redirect_to teaching_enrollments_path(current_course)
  end
end