class Studying::BaseController < ApplicationController
  require_login
  include Disciplines::TimeZone
  
  private
    def current_student
      @current_student ||= current_person.becomes(Student)
    end
    
    def current_studier
      if params[:studying_id].present?
        @studier ||= current_student.studiers.find_by_course_id! params[:studying_id]
      end
    end

    def current_course
      current_studier.try :course
    end
end