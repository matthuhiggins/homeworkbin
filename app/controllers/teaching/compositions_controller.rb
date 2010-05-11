class Teaching::CompositionsController < Teaching::BaseController
  topic 'homework'

  def update
    # current_submission.update_attributes params[:composition]
    render :json => {foo: 'bar'}
    # head :ok
  end
  
  private
    def current_submission
      @current_submission ||= current_course.submissions.find params[:id]
    end
    helper_method :current_submission
end