require 'active_record_test'

class AssignmentTest < ActiveRecord::TestCase
  def test_teaching_delegation
    assignment = factory.create
    assert_equal assignment.course.teacher, assignment.teacher
  end

  def test_last
    course = Factory.course.create
    first_assignment = factory.create course: course
    second_assignment = factory.create course: course
    new_assignment = factory.build course: course
    
    assert_equal second_assignment, new_assignment.last
  end
end