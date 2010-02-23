require 'active_support_test'

module ActionView
  class TestCase
    setup :setup_cookies_and_params
    
    attr_accessor :cookies, :params
    def setup_cookies_and_params
      @cookies = {}
      @params = {}
    end
  end

  autoload :TeachingTestCase, 'action_view/teaching_test_case'
end