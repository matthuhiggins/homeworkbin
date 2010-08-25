require 'active_support_test'

class SchoolTest < ActiveSupport::TestCase
  def test_initialize
    school = School.new

    assert_equal school.teacher, school.course.teacher
    assert_equal School.student_names.size, school.studiers.size
  end
end