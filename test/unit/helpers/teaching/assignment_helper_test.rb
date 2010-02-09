require 'action_view_test'

class Teaching::AssignmentHelperTest < ActionView::TestCase
  def test_due_minutes_uses_existing_value
    assignment = Factory :assignment, :due_minutes => 120

    assert 120, assignment_due_minutes(assignment)
  end

  def test_due_minutes_default_without_last
    assignment = Factory :assignment, :due_minutes => nil
    
    assert_equal 12 * 60, assignment_due_minutes(assignment)
  end
  
  def test_due_minutes_defaults_to_last
    course = Factory :course
    Factory :assignment, :course => course, :due_minutes => 120
    
    assignment = course.assignments.new
    
    assert_equal 120, assignment_due_minutes(assignment)
  end
end