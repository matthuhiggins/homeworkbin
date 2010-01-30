require 'active_support_test'
require 'action_controller/request_methods'

module ActionController
  TestCase.class_eval do
    extend RequestMethods
  end

  autoload :PersonTestCase, 'action_controller/person_test_case'
  autoload :StudyingTestCase, 'action_controller/studying_test_case'
  autoload :TeachingTestCase, 'action_controller/teaching_test_case'
end