class Studying::CoursesController < Studying::BaseController
  def index
    @courses = current_student.studying
  end

  def show
  end
  
  private
    def current_course
      if params[:id].present?
        @current_course ||= current_student.studying.find params[:id]
      end
    end
end