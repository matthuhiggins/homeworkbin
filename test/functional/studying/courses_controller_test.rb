require 'action_controller_test'

class Studying::CoursesControllerTest < ActionController::StudyingTestCase
  def test_index
    studying_get :index
    
    assert_not_nil assigns(:courses)
  end

  def show
    studying_get :show, :id => current_course.to_param
    
    assert_equal current_course, assigns(:course)
  end
end