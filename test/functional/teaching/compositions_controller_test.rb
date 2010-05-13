require 'action_controller_test'

class Teaching::CompositionsControllerTest < ActionController::TeachingTestCase
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
      composition: {
        annotated: '<span class="annotation a_1">realy</span> cool',
        annotations_attributes: [
          {
            identifier: 1,
            comment: 'mispelling',
            snippet: 'realy'
          }
        ]
      }
    }

    submission.reload
    assert_equal '<span class="annotation a_1">realy</span> cool', submission.annotated
    assert_equal 1, submission.annotations.count
  end

  private
    def create_submission(attributes = {})
      assignment = Factory.assignment.create course: current_course
      studier = Factory.studier.create course: current_course
      Factory.submission.create attributes.reverse_merge(
        assignment: assignment,
        studier: studier
      )
    end
end