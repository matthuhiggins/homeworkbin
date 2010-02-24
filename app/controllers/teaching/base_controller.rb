class Teaching::BaseController < ApplicationController
  layout 'teaching'
  require_login
  include Disciplines::TimeZone
  
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