require 'action_controller_test'

class Studying::EnrollmentsControllerTest < ActionController::TestCase
  def test_show
    enrollment = Factory :enrollment

    get :show, :id => enrollment.to_param
    
    assert_equal enrollment, assigns(:enrollment)
  end
  
  def test_update
    
  end
  
  def test_destroy
    enrollment = Factory :enrollment
    
    delete :destroy, :id => enrollment.to_param
    
    assert_redirected_to root_path
    assert_raise ActiveRecord::RecordNotFound do
      enrollment.reload
    end
  end
end