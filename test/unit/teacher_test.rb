require 'test_helper'

class TeacherTest < ActiveSupport::TestCase
  def test_courses_available_default
    assert_equal 1, Factory(:teacher).courses_available
  end
  
  def test_started_as_teacher_default
    assert Factory(:teacher).started_as_teacher
  end
end