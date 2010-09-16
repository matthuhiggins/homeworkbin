require 'action_controller_test'

class Studying::CoursesControllerTest < ActionController::StudyingTestCase
  matches_resources 'studying'
  
  test 'index' do
    studying_get :index

    assert_not_nil assigns(:courses)
  end

  test 'show' do
    studying_get :show, id: current_course.to_param

    assert_response :ok
  end
end