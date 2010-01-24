class Teaching::EnrollmentsController < Teaching::BaseController
  def create
    current_course.enrollments.matriculate_emails params[:emails]
    flash[:notice] = "Good work"
    redirect_to 'http://www.google.com'
  end
end