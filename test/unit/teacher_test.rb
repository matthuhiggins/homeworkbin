require 'active_record_test'

class TeacherTest < ActiveRecord::TestCase
  def test_courses_available_default
    assert_equal 1, factory.create.courses_available
  end
  
  def test_registered_as_teaching_default
    assert factory.create.registered_as_teacher
  end
end