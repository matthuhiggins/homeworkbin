require 'active_record_test'

class AssignmentTest < ActiveRecord::TestCase
  def test_teaching_delegation
    assignment = Factory :assignment
    assert_equal assignment.course.teacher, assignment.teacher
  end

  def test_last
    course = Factory :course
    first_assignment = Factory :assignment, :course => course
    second_assignment = Factory :assignment, :course => course
    new_assignment = Factory.build :assignment, :course => course
    
    assert_equal second_assignment, new_assignment.last
  end
end