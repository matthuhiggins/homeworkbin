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
end