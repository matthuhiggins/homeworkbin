require 'action_controller_test'

class Teaching::EnrollmentsControllerTest < ActionController::TeachingTestCase
  def test_index
    teaching_get :index
    assert_not_nil assigns(:enrollments)
  end
  
  def test_create
    teaching_post :create, :emails => 'sam@u.washington.edu, joe@yahoo.com'
    
    assert_equal 2, current_course.enrollments.size
    assert_redirected_to teaching_studiers_path(current_course)
  end
end
