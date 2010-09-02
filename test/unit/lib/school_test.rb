require 'active_support_test'

class SchoolTest < ActiveSupport::TestCase
  def test_initialize
    school = School.new

    assert_equal school.teacher.courses.to_set, school.courses.to_set
    assert_equal School.student_names.size, school.students.size
  end
end