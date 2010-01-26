class Teaching::StudentsController < Teaching::BaseController
  def index
    @students = current_course.students
  end
  
  def show
    @student = current_course.students.find params[:id]
  end
  
  def destroy
    @student = current_course.students.find params[:id]
    @student.destroy
    redirect_to teaching_students_path(current_course)
  end
end