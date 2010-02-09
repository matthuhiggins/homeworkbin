require 'action_controller_test'

class Teaching::AssignmentsControllerTest < ActionController::TeachingTestCase
  def test_index
    teaching_get :index
    assert_equal current_course.assignments, assigns(:assignments)
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
end