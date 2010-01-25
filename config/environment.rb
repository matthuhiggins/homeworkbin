RAILS_GEM_VERSION = '2.3.5' unless defined? RAILS_GEM_VERSION

require File.join(File.dirname(__FILE__), 'boot')

Rails::Initializer.run do |config|
  config.time_zone = 'UTC'

  config.gem 'matthuhiggins-foreigner', :version => '0.4.1',    :lib => 'foreigner'
  config.gem 'will_paginate',           :version => '2.3.11',   :lib => 'will_paginate'
  config.gem 'factory_girl',            :version => '1.2.3',    :lib => 'factory_girl'
  config.gem 'json',                    :version => '1.2.0'
  
  config.action_mailer.default_url_options = {
    :host => 'www.homeworkbin.com',
    :only_path => false
  }
  
  config.action_mailer.delivery_method = :smtp

  config.after_initialize do
    ActiveSupport::JSON.backend = 'JSONGem'
  end
end