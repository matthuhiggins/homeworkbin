ENV["RAILS_ENV"] = "test"
require File.expand_path(File.dirname(__FILE__) + "/../config/environment")
require 'test_help'

module ActiveSupport
  class TestCase
    self.use_transactional_fixtures = true
  
    class << self
      def target_klass
        guess_klass_name.constantize
      rescue NameError
        nil
      end
  
      def factory_name
        guess_klass_name.underscore
      end
    
      def guess_klass_name
        name.sub(/(::.*)|Test$/, '')
      end
    end
  end
end