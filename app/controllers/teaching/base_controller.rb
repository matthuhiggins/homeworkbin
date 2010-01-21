class Teaching::BaseController < ApplicationController
  layout 'classroom'
  require_login
  
  private
    def current_teacher
      @current_teacher ||= current_person.becomes(Teacher)
    end
    helper_method :current_teacher
    
    def current_course
      if params[:teaching_id].present?
        @current_course ||= current_teacher.teaching.find params[:teaching_id]
      end
    end
    helper_method :current_course
end