require 'action_controller_test'

class Studying::EnrollmentsControllerTest < ActionController::TestCase
  matches_resources 'enroll'

  def test_show
    enrollment = Factory :enrollment

    get :show, :id => enrollment.to_param
    
    assert_equal enrollment, assigns(:enrollment)
  end
  
  def test_update_new_student
    enrollment = Factory :enrollment
    
    put :update,
      :id         => enrollment.to_param, 
      :enrollment => {
        :student            => Factory.attributes_for(:student),
        :accept_enrollment  => '1'
      }
    
    assert_logged_in_as assigns(:enrollment).student
    assert_redirected_to studying_path(enrollment.course)
  end
  
  def test_update_new_invalid_student
    enrollment = Factory :enrollment
    
    put :update,
      :id         => enrollment.to_param,
      :enrollment => {
        :student            => {:email => 'foo'},
        :accept_enrollment  => '1'
      }
    
    assert_template 'show'
  end
  
  def test_update_existing_student
    student = Factory :student
    enrollment = Factory :enrollment, :email => student.email
    
    put :update,
      :id         => enrollment.to_param,
      :enrollment => {
        :accept_enrollment  => '1',
        :student            => {:automatically_enroll => '1'}
      }
    
    assert_logged_in_as student
    assert_redirected_to studying_path(enrollment.course)
  end
  
  def test_destroy
    enrollment = Factory :enrollment
    
    delete :destroy, :id => enrollment.to_param
    
    assert_redirected_to root_path
    assert_destroyed enrollment
  end
end