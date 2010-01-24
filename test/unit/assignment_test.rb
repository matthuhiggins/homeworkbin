require 'test_helper'

class AssignmentTest < ActiveSupport::TestCase
  def test_notify_students
    course = Factory :course
    course.students << Factory(:student)
    course.students << Factory(:student)
    
    assert_emails 2 do
      Factory :assignment, :course => course
    end
  end
end