require 'active_record_test'

class AssignmentTest < ActiveRecord::TestCase
  def test_teaching_delegation
    assignment = Factory :assignment
    assert_equal assignment.course.teacher, assignment.teacher
  end

  def test_validate_due_date_within_course
    course = Factory :course

    assert (assignment = Factory.build(:assignment, :due_date => course.start_date - 1)).invalid?
    assert_equal 'is before this course', assignment.errors.on(:due_date)

    assert (assignment = Factory.build(:assignment, :due_date => course.end_date + 1)).invalid?
    assert_equal 'is after this course', assignment.errors.on(:due_date)
    
    assert (assignment = Factory.build(:assignment, :due_date => course.start_date)).valid?
    assert (assignment = Factory.build(:assignment, :due_date => course.end_date)).valid?
  end

  def test_last
    course = Factory :course
    first_assignment = Factory :assignment, :course => course
    second_assignment = Factory :assignment, :course => course
    new_assignment = Factory.build :assignment, :course => course
    
    assert_equal second_assignment, new_assignment.last
  end
end