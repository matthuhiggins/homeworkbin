require 'action_controller_test'

class Teaching::AssignmentsControllerTest < ActionController::TeachingTestCase
  def test_index
    teaching_get :index
    assert_equal({}, assigns(:grouped_assignments))
  end

  def test_new
    teaching_get :new
    assert_kind_of Assignment, assigns(:assignment)
  end
  
  def test_create
    teaching_post :create, :assignment => {
      :name         => 'CSE 142',
      :due_date     => (current_course.start_date + 5).strftime('%m/%d/%Y'),
      :due_minutes  => 100
    }
    
    assert !assigns(:assignment).new_record?
    assert_redirected_to teaching_assignment_path(current_course, assigns(:assignment))
  end
  
  def test_edit
    assignment = Factory :assignment, :course => current_course 

    teaching_get :edit, :id => assignment.to_param

    assert_equal assignment, assigns(:assignment)
  end
  
  def test_update
    assignment = Factory :assignment, :course => current_course 
    
    teaching_put :update, {
      :id         => assignment.to_param,
      :assignment => {:name => 'foo!'}
    }
    
    assignment.reload
    assert_equal 'foo!', assignment.name
    assert_redirected_to teaching_assignment_path(current_course, assignment)
  end
end