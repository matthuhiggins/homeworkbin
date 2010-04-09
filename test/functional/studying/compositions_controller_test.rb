require 'action_controller_test'

class Studying::CompositionsControllerTest < ActionController::StudyingTestCase
  matches_resource 'studying/:studying_id/homework/:assignment_id/composition'

  def test_new_compostion
    studying_get :show, :assignment_id => assignment

    assert_kind_of Composition, assigns(:current_composition)
    assert_equal assignment, assigns(:current_composition).assignment
    assert_equal current_studier, assigns(:current_composition).studier
  end
  
  def test_edit_compostion
    composition = Factory.composition.create :assignment => assignment, :studier => current_studier
    
    studying_get :show, :assignment_id => assignment
    
    assert_equal composition, assigns(:current_composition)
  end

  def test_update_before_composition_exists
    studying_put :update, {
      :assignment_id => assignment,
      :composition => {:text => 'The quick brown fox jumped over the lazy dog'}
    }
    
    assert !assigns(:current_composition).new_record?
  end
  
  def test_update_existing_composition
    composition = Factory.composition.create :assignment => assignment, :studier => current_studier
    
    studying_put :update, {
      :assignment_id => assignment,
      :composition => {:text => 'poo poo'}
    }
    
    composition.reload
    assert_equal 'poo poo', composition.text
  end

  private
    def assignment
      @assignment ||= Factory.assignment.create :course => current_course
    end
end