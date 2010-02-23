class ApplicationController < ActionController::Base
  helper :all
  protect_from_forgery
  filter_parameter_logging :password
  before_filter :set_time_zone
  
  include Disciplines::HallMonitor
  include Disciplines::TimeZone
  include Disciplines::Topic
end
