require 'action_controller_test'

class ApplicationControllerTest < ActionController::TestCase
  class TestController < ApplicationController
    def index
      render text: 'foo'
    end
  end

  tests TestController

  test 'current_course' do
    with_generic_routes do
      get :index
      assert_nil @controller.send(:current_course)
    end
  end
end