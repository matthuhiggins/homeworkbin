class Studying::CoursesController < Studying::BaseController
  def index
    @courses = current_student.studying
  end

  def show
  end
  
  private
    def current_course
      if params[:id].present?
        @current_studier ||= current_student.studiers.find_by_course_id! params[:id]
      end
    end
end