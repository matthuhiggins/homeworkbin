require 'active_support_test'
require 'action_controller/request_methods'
require 'action_controller/hall_monitor_assertions'

module ActionController
  TestCase.class_eval do
    extend RequestMethods
    include HallMonitorAssertions
  end

  autoload :PersonTestCase, 'action_controller/person_test_case'
  autoload :StudyingTestCase, 'action_controller/studying_test_case'
  autoload :TeachingTestCase, 'action_controller/teaching_test_case'
end