require 'action_controller_test'

class Teaching::SubmissionsControllerTest < ActionController::TeachingTestCase
  matches_resources 'teaching/:teaching_id/submissions'

  def test_show
    assignment = Factory.assignment.create :course => current_course
    studier = Factory.studier.create :course => current_course
    submission = Factory.submission.create :assignment => assignment, :studier => studier

    teaching_get :show, :id => submission.to_param

    assert_response :ok
  end
end