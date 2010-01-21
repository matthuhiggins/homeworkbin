class Studying::CompositionsController < Studying::BaseController
  def new
    @composition = Composition.new
  end
  
  def create
    @composition = current_studier.compositions.build params[:composition]
    if @composition.save
      flash[:notice] = "Composition saved"
      redirect_to studying_composition(current_course, current_assignment)
    else
      render 'new'
    end
  end
  
  private
    def current_assignment
      current_course.assignments.find params[:assignment_id]
    end
    helper_method :current_assignment
end