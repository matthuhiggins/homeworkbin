class Teaching::AssignmentsController < Teaching::BaseController
  shows_topic 'homework'

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
      redirect_to teaching_assignment_path(current_course, @assignment), notice: 'New assignment!'
    else
      render 'new'
    end
  end
  
  def show
    @assignment = current_course.assignments.find params[:id]
    @submissions = @assignment.submissions.includes studier: :student
  end
  
  def edit
    @assignment = current_course.assignments.find params[:id]
  end
  
  def update
    @assignment = current_course.assignments.find params[:id]
    if @assignment.update_attributes params[:assignment]
      redirect_to teaching_assignment_path(current_course, @assignment), notice: 'Assignment saved'
    else
      render 'edit'
    end
  end
  
  def destroy
    @assignment = current_course.assignments.find params[:id]
    @assignment.destroy
    redirect_to teaching_assignments_path(current_course), notice: 'Assignment deleted'
  end
end