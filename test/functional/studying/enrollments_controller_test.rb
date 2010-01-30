require 'action_controller_test'

class Studying::EnrollmentsControllerTest < ActionController::TestCase
  def test_show
    enrollment = Factory :enrollment

    get :show, :id => enrollment.to_param
    
    assert_equal enrollment, assigns(:enrollment)
  end
end