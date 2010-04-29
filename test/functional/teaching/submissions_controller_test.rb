require 'action_controller_test'

class Teaching::SubmissionsControllerTest < ActionController::TeachingTestCase
  matches_resources 'teaching/:teaching_id/submissions'

  def test_show
    submission = create_submission

    teaching_get :show, id: submission.to_param

    assert_response :ok
  end

  def test_update
    submission = create_submission

    teaching_put :update, {
      id: submission.to_param,
      submission: {}
    }
  end

  private
    def create_submission
      assignment = Factory.assignment.create course: current_course
      studier = Factory.studier.create course: current_course
      Factory.submission.create assignment: assignment, studier: studier
    end
end