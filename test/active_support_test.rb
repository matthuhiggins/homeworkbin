ENV["RAILS_ENV"] = "test"
require File.expand_path(File.dirname(__FILE__) + "/../config/environment")
require 'rails/test_help'

module ActiveSupport
  class TestCase
    self.use_transactional_fixtures = true
  
    class << self
      def target_klass
        guess_klass_name.constantize
      rescue NameError
        nil
      end

      def factory
        Factory[guess_klass_name.underscore]
      end

      def guess_klass_name
        name.sub(/(::.*)|Test$/, '')
      end
    end
    
    def with_time_zone time_zone
      original_time_zone = Time.zone
      Time.zone = time_zone
      yield
    ensure
      Time.zone = original_time_zone
    end

    def factory
      self.class.factory
    end
    
    def assert_destroyed(record)
      assert_raise ActiveRecord::RecordNotFound do
        record.class.find record
      end
    end

    def assert_not_destroyed(record)
      assert_nothing_raised do
        record.class.find record
      end
    end
  end
end