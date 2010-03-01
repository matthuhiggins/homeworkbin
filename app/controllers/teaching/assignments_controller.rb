class Teaching::AssignmentsController < Teaching::BaseController
  topic 'homework'

  def index
    @upcoming_assignments = current_course.assignments.upcoming.all
    @past_assignments = current_course.assignments.past.all
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
    @submissions = @assignment.submissions.all(:include => {:studier => :student})
  end
  
  def edit
    @assignment = current_course.assignments.find params[:id]
  end
  
  def update
    @assignment = current_course.assignments.find params[:id]
    if @assignment.update_attributes params[:assignment]
      flash[:notice] = 'Assignment saved'
      redirect_to teaching_assignment_path(current_course, @assignment)
    else
      render 'edit'
    end
  end
  
  def destroy
    @assignment = current_course.assignments.find params[:id]
    @assignment.destroy
    flash[:notice] = 'Assignment deleted'
    redirect_to teaching_assignments_path(current_course)
  end
  
  private
    def current_course
      @current_course ||= current_teacher.teaching.find params[:teaching_id]
    end
end