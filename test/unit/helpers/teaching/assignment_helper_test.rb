require 'action_view_test'

class Teaching::AssignmentHelperTest < ActionView::TestCase
  def test_due_minutes_without_last
    assert 120, assignment_due_minutes(Factory.build :assignment, :due_minutes => 120)
    assert_equal 12 * 60, assignment_due_minutes(Factory.build :assignment, :due_minutes => nil)
  end

  def test_due_minutes_defaults_to_last
    course = Factory :course
    Factory :assignment, :course => course, :due_minutes => 120
    
    assignment = course.assignments.new
    
    assert_equal 120, assignment_due_minutes(assignment)
  end
  
  def test_due_date
    assert_equal '12/25/2005', assignment_due_date(Factory.build :assignment, :due_date => '12/25/2005')
    assert_equal Date.current.strftime('%m/%d/%Y'), assignment_due_date(Factory.build :assignment_without_due)
  end
  
  def test_assignment_due_at
    assignment = Factory.build :assignment

    assert_equal assignment.due_date.strftime('%a, %b %d'), assignment_due_at(assignment)
  end
  
  def test_handout
    assert assignment_handout(Factory :assignment, :handout => '1')
    assert assignment_handout(Factory :assignment, :handout => nil)
    assert !assignment_handout(Factory :assignment, :handout => '0')
  end
  
  def test_next_assignment
    assignment = Factory :assignment
    
    next_assignment Assignment.scoped({}) do |a|
      assert_equal assignment, a
    end
  end
  
  def test_next_assignment_when_nil
    next_assignment Assignment.scoped({}) do |a|
      assert false, 'Should not enter block'
    end
  end
end