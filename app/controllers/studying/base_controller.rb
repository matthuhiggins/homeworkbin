class Studying::BaseController < ApplicationController
  require_login
  shows_sub_menu 'studying'
  
  private
    def current_student
      current_person.student
    end
    
    def current_studier
      @current_studier ||= current_student.studiers.find_by_course_id! params[:studying_id]
    end
    helper_method :current_studier

    def current_course
      current_studier.try :course
    end
end