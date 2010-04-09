require 'action_controller_test'

class Studying::BaseControllerTest < ActionController::StudyingTestCase
  tests Teaching::AssignmentsController
  
  def test_context
    # studying_get :index
    # 
    # assert_equal current_student, @controller.send(:current_student)
    # assert_equal current_studier, @controller.send(:current_studier)
    # assert_equal current_course, @controller.send(:current_course)
  end
end