ENV["RAILS_ENV"] = "test"
require File.expand_path(File.dirname(__FILE__) + "/../config/environment")
require 'test_help'

class ActiveSupport::TestCase
  self.use_transactional_fixtures = true
  
  def target_class
    self.class.name.sub(/Test$/, '').constantize
  rescue NameError
    nil
  end

  module Concerns
    # extend ActiveSupport::Autoload
    autoload :EmailValidationTests, 'concerns/email_validation_tests'
    autoload :TokenizedTests, 'concerns/tokenized_tests'
  end
end

module ActionController
  autoload :StudentTestCase, 'concerns/student_test_case'
  autoload :TeacherTestCase, 'concerns/teacher_test_case'
end