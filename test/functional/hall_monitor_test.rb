require 'action_controller_test'

class HallMonitorTest < ActionController::TestCase
  class TestController < ActionController::Base
    attr_accessor :person
    include HallMonitor
    
    require_login :only => [:action_requiring_login]
    
    def login_without_options
      login person
    end
    
    def login_with_remember_me
      login person, :remember => true
    end
    
    def login_with_redirect
      login person, :redirect => '/foo'
    end
    
    def action_requiring_login
      render :text => 'foo'
    end
  end
  
  def setup
    @person = Factory :person
    @controller = TestController.new
    @controller.person = @person
  end
  
  def test_login_with_remember_me
    get :login_with_remember_me

    assert_logged_in_as @person
    assert_remembered_as @person
  end
  
  def test_login_with_redirect
    get :login_with_redirect

    assert_logged_in_as @person
    assert_redirected_to '/foo'
  end
  
  def test_login_with_original_uri
    get :login_without_options, {}, :original_uri => '/foo'
    
    assert_redirected_to '/foo'
  end
  
  def test_action_requiring_login
    get :action_requiring_login
    
    assert_redirected_to login_path
    assert_equal '/hall_monitor_test/test/action_requiring_login', @controller.session[:original_uri]
  end
end