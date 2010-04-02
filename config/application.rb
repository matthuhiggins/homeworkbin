require File.expand_path('../boot', __FILE__)

require 'rails/all'

Bundler.require(:default, Rails.env) if defined?(Bundler)

module Homeworkbin
  class Application < Rails::Application
    # config.time_zone = 'UTC'
    # 
    # config.action_mailer.default_url_options = {
    #   :host => 'homeworkbin.com',
    #   :only_path => false
    # }

    # Configure sensitive parameters which will be filtered from the log file.
    # config.filter_parameters << :password
  end
end
