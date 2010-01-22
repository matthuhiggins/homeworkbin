class Studying::CompositionsController < Studying::BaseController
  def new
    @composition = current_studier.compositions.new
  end
  
  def create
    @composition = current_studier.compositions.build params[:composition]
    @composition.assignment = current_assignment

    if @composition.save
      flash[:notice] = "Composition saved"
      redirect_to studying_composition_path(current_course, current_assignment)
    else
      render 'new'
    end
  end
  
  def show
    @composition = current_studier.compositions.find params[:id]
  end
  
  private
    def current_assignment
      current_course.assignments.find params[:assignment_id]
    end
    helper_method :current_assignment
end