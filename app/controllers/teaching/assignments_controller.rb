class Teaching::AssignmentsController < Teaching::BaseController
  def index
    @assignments = current_course.assignments
  end
  
  def new
    @assignment = current_course.assignments.new
  end
  
  def create
    @assignment = current_course.assignments.build params[:assignment]
    if @assignment.save
      flash[:notice] = "New assignment!"
      redirect_to teaching_assignment_path(current_course, @assignment)
    else
      render 'new'
    end
  end
  
  def show
    @assignment = current_course.assignments.find params[:id]
  end
  
  def edit
    @assignment = current_course.assignments.find params[:id]
  end
  
  def update
    @assignment = current_course.assignments.find params[:id]
    if @assignment.update_attributes params[:assignment]
      flash[:notice] = "Assignment saved"
    else
      render 'edit'
    end
  end
  
  private
    def current_course
      @current_course ||= current_teacher.teaching.find params[:teaching_id]
    end
end