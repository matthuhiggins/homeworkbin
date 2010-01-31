require 'action_controller_test'

class Studying::EnrollmentsControllerTest < ActionController::TestCase
  def test_show
    enrollment = Factory :enrollment

    get :show, :id => enrollment.to_param
    
    assert_equal enrollment, assigns(:enrollment)
  end
  
  def test_update_new_student
    enrollment = Factory :enrollment
    
    put :update,
        :id => enrollment.to_param, 
        :enrollment => {:student => Factory.attributes_for(:student)}
    
    assert_logged_in_as assigns(:enrollment).student
  end
  
  def test_update_new_invalid_student
    enrollment = Factory :enrollment
    
    put :update,
        :id => enrollment.to_param, 
        :enrollment => {:student => {:email => 'foo'}}
    
    assert_template 'show'
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