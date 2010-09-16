require 'action_controller_test'

class ApplicationControllerTest < ActionController::TestCase
  class TestController < ApplicationController
    def index
      render text: 'foo'
    end
  end

  tests TestController

  test 'context' do
    with_generic_routes do
      get :index
      assert !@controller.send(:teaching?)
      assert !@controller.send(:studying?)
    end
  end
end