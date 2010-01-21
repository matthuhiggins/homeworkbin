class Teaching::BaseController < ApplicationController
  layout 'classroom'
  require_login
  
  private
    def current_teacher
      @current_teacher ||= current_person.becomes(Teacher)
    end
    helper_method :current_teacher
end