require 'active_support_test'

module ActionView
  TestCase.class_eval do
    setup :setup_cookies_and_params
    
    attr_accessor :cookies, :params
    def setup_cookies_and_params
      @cookies = {}
      @params = {}
    end
    
    def current_course
      @current_course ||= Factory(:course)
    end
  end
  # autoload :TeachingTestCase, 'action_view/teaching_test_case'
end