require 'active_support_test'
require 'action_controller/request_methods'
require 'action_controller/hall_monitor_assertions'
require 'action_controller/route_assertions'

module ActionController
  # Homeworkbin::Application.routes.draw { |map| map.connect ':controller/:action/:id' }
  
  TestCase.class_eval do
    extend RequestMethods
    include RouteAssertions
    include HallMonitorAssertions

    def with_generic_routes
      with_routing do |set|
        set.draw do
          match ':controller(/:action(/:id(.:format)))'
        end
        yield
      end
    end
  end

  autoload :PersonTestCase, 'action_controller/person_test_case'
  autoload :StudyingTestCase, 'action_controller/studying_test_case'
  autoload :TeachingTestCase, 'action_controller/teaching_test_case'
end