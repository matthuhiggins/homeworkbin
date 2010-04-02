class Studying::BaseController < ApplicationController
  require_login
  
  private
    def current_student
      current_person.student
    end
    
    def current_studier
      @current_studier ||= current_student.studiers.find_by_course_id! params[:studying_id]
    end

    def current_course
      current_studier.try :course
    end
end