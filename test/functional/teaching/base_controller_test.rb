require 'action_controller_test'

class Teaching::BaseControllerTest < ActionController::TeachingTestCase
  tests Teaching::AssignmentsController
  
  def test_context
    teaching_get :index

    assert_equal current_teacher, @controller.send(:current_teacher)
    assert_equal current_course, @controller.send(:current_course)
  end
end