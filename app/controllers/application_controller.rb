class ApplicationController < ActionController::Base
  protect_from_forgery
  layout 'whiteboard'
  
  include Disciplines::HallMonitor
  include Disciplines::TimeZone
  include Disciplines::Topic
  
  private
    def current_course
      nil
    end
    helper_method :current_course
end
