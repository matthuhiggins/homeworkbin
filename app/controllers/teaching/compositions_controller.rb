class Teaching::CompositionsController < Teaching::BaseController
  topic 'homework'

  def update
    current_composition.update_attributes params[:composition]
    render :json => {foo: 'bar'}
    # head :ok
  end
  
  private
    def current_composition
      @current_composition ||= current_course.submissions.find params[:id]
    end
    helper_method :current_composition
end