class Teaching::BaseController < ApplicationController
  require_login
  
  private
    def current_teacher
      current_person.teacher
    end
    helper_method :current_teacher
    
    def current_course
      @current_course ||= current_teacher.teaching.find params[:teaching_id]
    end
end