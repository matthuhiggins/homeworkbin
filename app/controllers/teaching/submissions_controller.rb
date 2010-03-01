class Teaching::SubmissionsController < Teaching::BaseController
  topic 'homework'
  
  def show
  end
  
  private
    def current_submission
      @current_submission ||= current_course.submissions.find params[:id]
    end
    helper_method :current_submission
end