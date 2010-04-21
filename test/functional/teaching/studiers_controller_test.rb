require 'action_controller_test'

class Teaching::StudiersControllerTest < ActionController::TeachingTestCase
  matches_resources 'teaching/:teaching_id/students'

  def test_index
    teaching_get :index
    assert_not_nil assigns(:studiers)
  end
  
  def test_show
    studier = Factory.studier.create course: current_course
    
    teaching_get :show, id: studier.to_param
    
    assert_equal studier, assigns(:studier)
  end
  
  def test_destroy
    studier = Factory.studier.create course: current_course

    teaching_delete :destroy, id: studier.to_param

    assert_destroyed studier
  end
end