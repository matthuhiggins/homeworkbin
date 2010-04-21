require 'action_controller_test'

class Teaching::EnrollmentsControllerTest < ActionController::TeachingTestCase
  matches_resources 'teaching/:teaching_id/enroll'

  def test_index
    teaching_get :index
    assert_not_nil assigns(:enrollments)
  end
  
  def test_create
    teaching_post :create, emails: 'sam@u.washington.edu, joe@yahoo.com'
    
    assert_equal 2, current_course.enrollments.size
    assert_redirected_to teaching_studiers_path(current_course)
  end
  
  def test_destroy
    enrollment = Factory.enrollment.create course: current_course
    
    teaching_delete :destroy, id: enrollment.to_param
    
    assert_destroyed enrollment
    assert_redirected_to teaching_enrollments_path(current_course)
  end
end
