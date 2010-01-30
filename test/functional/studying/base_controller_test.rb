require 'action_controller_test'

class Studying::BaseControllerTest < ActionController::StudentTestCase
  class Controller < Studying::BaseController
    def index
      render :text => 'foo'
    end
  end
  
  tests Controller
  
  def test_authentication
    get :index
    assert_redirected_to login_path
  end
end