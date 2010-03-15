require 'action_controller_test'

class Teaching::AnnotationsControllerTest < ActionController::TeachingTestCase
  def test_create
    teaching_post :create, {
      :submission_id => create_submission.to_param,
      :annotation => {
        :comment => 'gold star',
        :snippet => 'green symbolizes envy'
      }
    }

    assert !assigns(:annotation).new_record?
    assert_equal({:id => assigns(:annotation).id}.to_json, @response.body)
  end
  
  def test_destroy
    submission = create_submission
    annotation = Factory :annotation, :submission => submission

    teaching_delete :destroy, {
      :submission_id  => submission.to_param,
      :id             => annotation.to_param
    }

    assert_response :ok
    assert_destroyed annotation
  end

  private
    def create_submission
      assignment = Factory :assignment, :course => current_course
      studier = Factory :studier, :course => current_course
      Factory(:submission, :assignment => assignment, :studier => studier)
    end
end