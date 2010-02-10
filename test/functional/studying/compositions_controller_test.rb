require 'action_controller_test'

class Studying::CompositionsControllerTest < ActionController::StudyingTestCase
  def test_new_compostion
    studying_get :show, :assignment_id => assignment

    assert_kind_of Composition, assigns(:composition)
    assert_equal assignment, assigns(:composition).assignment
    assert_equal studier, assigns(:composition).studier
  end
  
  def test_edit_compostion
    composition = Factory :composition, :assignment => assignment, :studier => studier
    
    studying_get :show, :assignment_id => assignment
    
    assert_equal composition, assigns(:composition)
  end

  def test_update_before_composition_exists
    studying_put :update, {
      :assignment_id => assignment,
      :composition => {:text => "The quick brown fox jumped over the lazy dog"}
    }
    
    assert !assigns(:composition).new_record?
  end

  private
    def assignment
      @assignment ||= Factory(:assignment, :course => current_course)
    end
end