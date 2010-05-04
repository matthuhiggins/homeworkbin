class Teaching::AnnotationsController < Teaching::BaseController
  topic 'homework'
  
  def create
    @annotation = current_composition.annotations.create params[:annotation]
    render json: { id: @annotation.id }
  end
  
  def destroy
    @annotation = current_composition.annotations.find params[:id]
    @annotation.destroy
    head :ok
  end
  
  private
    def current_composition
      @current_composition ||= current_course.submissions.find params[:composition_id]
    end
end
  