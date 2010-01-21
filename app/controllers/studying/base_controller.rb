class Studying::BaseController < ApplicationController
  layout 'classroom'
  require_login
  
  private
    def current_student
      @current_student ||= current_person.becomes(Student)
    end
end