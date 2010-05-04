require 'action_controller_test'

class Teaching::AnnotationsControllerTest < ActionController::TeachingTestCase
  matches_resources 'teaching/:teaching_id/submissions/:composition_id/annotations'

  # def test_create
  #   teaching_post :create, {
  #     composition_id: create_composition.to_param,
  #     annotation: {
  #       comment: 'gold star',
  #       snippet: 'green symbolizes envy'
  #     }
  #   }
  # 
  #   assert !assigns(:annotation).new_record?
  #   assert_equal({id: assigns(:annotation).id}.to_json, @response.body)
  # end
  
  def test_destroy
    composition = create_composition
    annotation = Factory.annotation.create composition: composition

    teaching_delete :destroy, {
      :composition_id   => composition.to_param,
      :id               => annotation.to_param
    }

    assert_response :ok
    assert_destroyed annotation
  end

  private
    def create_composition
      assignment = Factory.assignment.create course: current_course
      studier = Factory.studier.create course: current_course
      Factory.submission.create assignment: assignment, studier: studier
    end
end