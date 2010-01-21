class Studying::BaseController < ApplicationController
  layout 'classroom'
  require_login
  
  private
    def current_student
      @current_student ||= current_person.becomes(Student)
    end
    
    def current_course
      if params[:studying_id].present?
        @current_course ||= current_student.studying.find params[:studying_id]
      end
    end
    helper_method :current_course
    
end