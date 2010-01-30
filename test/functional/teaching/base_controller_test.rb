require 'action_controller_test'

class Teaching::BaseControllerTest < ActionController::TeachingTestCase
  class Controller < Teaching::BaseController
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