require 'action_view_test'

class Teaching::AssignmentHelperTest < ActionView::TestCase
  def test_due_minutes_without_last
    assert 120, assignment_due_minutes(Factory.build(:assignment, :due_minutes => 120))
    assert_equal 12 * 60, assignment_due_minutes(Factory.build(:assignment, :due_minutes => nil))
  end

  def test_due_minutes_defaults_to_last
    course = Factory :course
    Factory :assignment, :course => course, :due_minutes => 120
    
    assignment = course.assignments.new
    
    assert_equal 120, assignment_due_minutes(assignment)
  end
  
  def test_due_date
    assert_equal '12/25/2005', assignment_date_date(Factory.build(:assignment, :due_date => '12/25/2005'))
    assert_equal Date.current.strftime('%m/%d/%Y'), assignment_date_date(Factory.build(:assignment, :due_date => nil))
  end
end