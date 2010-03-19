require 'action_controller_test'

class Teaching::SubmissionsControllerTest < ActionController::TeachingTestCase
  test_resources 'teaching/:teaching_id/submissions'

  def test_show
    assignment = Factory :assignment, :course => current_course
    studier = Factory :studier, :course => current_course
    submission = Factory :submission, :assignment => assignment, :studier => studier

    teaching_get :show, :id => submission.to_param

    assert_response :ok
  end
end