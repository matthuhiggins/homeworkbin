require 'active_record_test'

class TeacherTest < ActiveSupport::TestCase
  def test_courses_available_default
    assert_equal 1, Factory(:teacher).courses_available
  end
  
  def test_registered_as_teacher_default
    assert Factory(:teacher).registered_as_teacher
  end
end