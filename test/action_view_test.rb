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
    
    def controller_name
      @params[:controller] || 'test'
    end
    
    def action_name
      @params[:action] || 'index'
    end
  end
end