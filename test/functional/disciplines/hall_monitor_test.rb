require 'action_controller_test'

class Disciplines::HallMonitorTest < ActionController::TestCase
  class TestController < ActionController::Base
    attr_accessor :person, :root_path, :login_path
    include Disciplines::HallMonitor

    require_login only: [:action_requiring_login]

    def login_without_options
      login person
    end

    def login_with_remember_me
      login person, remember: true
    end

    def login_with_redirect
      login person, redirect: '/foo'
    end

    def action_requiring_login
      render text: 'foo'
    end
  end
  
  tests TestController
  
  def setup
    @person = Factory.person.create
    @controller.person = @person
    @controller.root_path = 'homely'
    @controller.login_path = 'loginz'
  end
  
  def test_login_with_remember_me
    with_generic_routes do
      get :login_with_remember_me

      assert_logged_in_as @person
      assert_remembered_as @person
    end
  end
  
  def test_login_with_redirect
    with_generic_routes do
      get :login_with_redirect

      assert_logged_in_as @person
      assert_redirected_to '/foo'
    end
  end
  
  def test_login_to_default_path
    with_generic_routes do
      get :login_without_options

      assert_redirected_to @controller.root_path
    end
  end

  def test_login_with_original_uri
    with_generic_routes do
      get :login_without_options, {}, original_uri: '/foo'

      assert_redirected_to '/foo'
    end
  end
  
  def test_action_requiring_login
    with_generic_routes do
      get :action_requiring_login

      assert_redirected_to @controller.login_path
      assert_equal(
        '/disciplines/hall_monitor_test/test/action_requiring_login',
        @controller.session[:original_uri]
      )
    end
  end
end