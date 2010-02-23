class Studying::CompositionsController < Studying::BaseController
  def update
    composition.attributes = params[:composition]

    if @composition.save
      flash[:notice] = "Composition saved"
      redirect_to studying_composition_path(current_course, assignment)
    else
      render 'new'
    end
  end
  
  def show
  end
  
  private
    def assignment
      current_course.assignments.find params[:assignment_id]
    end
    helper_method :assignment
    
    def composition
      @composition ||= begin
        current_studier.compositions.find_by_assignment_id(assignment) ||
        current_studier.compositions.new(:assignment => assignment)
      end
    end
    helper_method :composition
end