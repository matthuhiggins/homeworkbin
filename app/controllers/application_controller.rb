class ApplicationController < ActionController::Base
  helper :all
  protect_from_forgery
  filter_parameter_logging :password
  
  include Disciplines::HallMonitor
  include Disciplines::Topic
end
