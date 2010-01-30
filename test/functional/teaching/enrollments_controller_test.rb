require 'action_controller_test'

class Teaching::EnrollmentsControllerTest < ActionController::TeacherTestCase
  def test_index
    teacher_get :index
    assert_not_nil assigns(:enrollments)
  end
  
  def test_create
    teacher_post :create, :emails => 'sam@u.washington.edu, joe@yahoo.com'
    
    assert_equal 2, current_course.enrollments.size
    assert_redirected_to teaching_enrollments_path(current_course)
  end
end
