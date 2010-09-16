require 'action_controller_test'

class Studying::AssignmentsControllerTest < ActionController::StudyingTestCase
  matches_resources 'studying/:studying_id/homework'
  # confirm_hand_in
  # complete_hand_in

  test 'new compostion' do
    studying_get :show, id: assignment.to_param

    assert_kind_of Composition, assigns(:current_composition)
    assert_equal assignment, assigns(:current_composition).assignment
    assert_equal current_studier, assigns(:current_composition).studier
  end
  
  test 'edit_compostion' do
    composition = Factory.composition.create assignment: assignment, studier: current_studier
    
    studying_get :show, id: assignment.to_param
    
    assert_equal composition, assigns(:current_composition)
  end

  test 'update before composition_exists' do
    studying_put :update, {
      :id           => assignment.to_param,
      :composition  => {original: 'The quick brown fox jumped over the lazy dog'}
    }
    
    assert !assigns(:current_composition).new_record?
  end
  
  test 'update existing composition' do
    composition = Factory.composition.create assignment: assignment, studier: current_studier
    
    studying_put :update, {
      :id           => assignment.to_param,
      :composition  => {original: 'poo poo'}
    }
    
    composition.reload
    assert_equal 'poo poo', composition.original
    assert_redirected_to studying_path(current_course)
  end

  test 'confirm hand_in' do
    composition = Factory.composition.create assignment: assignment, studier: current_studier

    studying_get :confirm_hand_in, :id => assignment.to_param

    assert_response :ok
  end

  private
    def assignment
      @assignment ||= Factory.assignment.create course: current_course
    end
end