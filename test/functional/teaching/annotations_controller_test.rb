require 'action_controller_test'

class Teaching::AnnotationsControllerTest < ActionController::TeachingTestCase
  def test_create
    teaching_post :create, :submission_id => current_submission.to_param, :text => 'gold star'
    
    assert !assigns(:annotation).new_record?
    assert_equal({:id => assigns(:annotation).id}.to_json, @response.body)
  end
  
  private
    def current_submission
      assignment = Factory :assignment, :course => current_course
      studier = Factory :studier, :course => current_course
      @current_submission ||= Factory(:submission, :assignment => assignment, :studier => studier)
    end
end