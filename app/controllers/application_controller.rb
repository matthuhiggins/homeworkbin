class ApplicationController < ActionController::Base
  helper :all
  protect_from_forgery
  layout 'whiteboard'
  filter_parameter_logging :password
  
  include Disciplines::HallMonitor
  include Disciplines::TimeZone
  include Disciplines::Topic
  
  private
    def current_course
      nil
    end
    helper_method :current_course
end
