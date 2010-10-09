class Studying::AssignmentsController < Studying::BaseController
  shows_topic 'homework'
  
  def index
    render text: 'wtf'
  end
  
  def upcoming
    render text: 'poop'
  end

  def update
    current_composition.attributes = params[:composition]

    if current_composition.save
      redirect_to studying_path(current_course), notice: 'Homework saved'
    else
      render 'new'
    end
  end
  
  def show
  end
  
  private
    def current_assignment
      @current_assignment ||= current_course.assignments.find(params[:id])
    end
    helper_method :current_assignment

    def current_composition
      @current_composition ||= begin
        current_studier.compositions.find_by_assignment_id(current_assignment) ||
        current_studier.compositions.new(assignment: current_assignment)
      end
    end
    helper_method :current_composition
end