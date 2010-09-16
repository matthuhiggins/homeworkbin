require 'action_controller_test'

class Teaching::EnrollmentsControllerTest < ActionController::TeachingTestCase
  matches_resources 'teaching/:teaching_id/enroll'

  test 'index' do
    teaching_get :index
    assert_not_nil assigns(:enrollments)
  end
  
  test 'create' do
    teaching_post :create, emails: 'sam@u.washington.edu, joe@yahoo.com'
    
    assert_equal 2, current_course.enrollments.size
    assert_redirected_to teaching_studiers_path(current_course)
  end
  
  test 'destroy' do
    enrollment = Factory.enrollment.create course: current_course
    
    teaching_delete :destroy, id: enrollment.to_param
    
    assert_destroyed enrollment
    assert_redirected_to teaching_enrollments_path(current_course)
  end
end
