class Studying::CoursesController < Studying::BaseController
  def index
    @courses = current_student.studying
  end

  def show
    @course = current_student.studying.find params[:id]
  end
end