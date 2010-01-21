class Studying::BaseController < ApplicationController
  layout 'classroom'
  require_login
  
  private
    def current_student
      @current_student ||= current_person.becomes(Student)
    end
    
    def current_studier
      if params[:studying_id].present?
        @current_studier ||= current_student.studiers.find_by_course_id! params[:studying_id]
      end
    end

    def current_course
      current_studier.try :course
    end
    helper_method :current_course
end