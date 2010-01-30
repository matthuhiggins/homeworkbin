ENV["RAILS_ENV"] = "test"
require File.expand_path(File.dirname(__FILE__) + "/../config/environment")
require 'test_help'

class ActiveSupport::TestCase
  self.use_transactional_fixtures = true
  
  def target_klass
    self.class.name.sub(/Test$/, '').constantize
  rescue NameError
    nil
  end
  
  def factory_name
    self.class.name.sub(/Test$/, '').underscore
  end
end