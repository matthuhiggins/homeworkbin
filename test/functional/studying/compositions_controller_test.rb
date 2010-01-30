require 'action_controller_test'

class Studying::CompositionsControllerTest < ActionController::StudyingTestCase
  def test_new
    studying_get :new, :assignment_id => assignment.to_param
    assert_kind_of Composition, assigns(:composition)
  end
  
  def test_create
    studying_post :create, {
      :assignment_id => assignment.to_param,
      :composition => {:paper => "The quick brown fox jumped over the lazy dog"}
    }
    
    assert !assigns(:composition).new_record?
  end
  
  def test_show
    composition = Factory :composition, :assignment => assignment, :studier => current_studier
    
    studying_get :show, :id => composition.to_param
    
    assert_equal composition, assigns(:composition)
  end
  
  private
    def assignment
      @assignment ||= Factory(:assignment, :course => current_course)
    end
end