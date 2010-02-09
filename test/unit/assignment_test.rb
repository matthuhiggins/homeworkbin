require 'active_record_test'

class AssignmentTest < ActiveSupport::TestCase
  def test_teaching_delegation
    assignment = Factory :assignment
    assert_equal assignment.course.teacher, assignment.teacher
  end
end