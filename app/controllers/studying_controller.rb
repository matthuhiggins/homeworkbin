class StudyingController < ApplicationController
  layout 'classroom'
  require_login

  def index
    @courses = current_student.studying
  end
  
  def show
    @course = current_student.studying.find params[:id]
  end
  
  private
    def current_student
      @current_student ||= current_person.becomes(Student)
    end
end