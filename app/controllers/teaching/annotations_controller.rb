class Teaching::AnnotationsController < Teaching::BaseController
  topic 'homework'
  
  def create
    @annotation = current_submission.annotations.create params[:annotation]
    render :json => { :id => @annotation.id }
  end
  
  private
    def current_submission
      @current_submission ||= current_course.submissions.find params[:submission_id]
    end
end
  