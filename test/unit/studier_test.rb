require 'active_record_test'

class StudierTest < ActiveRecord::TestCase
  def test_delegation
    studier = Factory :studier

    assert_equal studier.course.teacher, studier.teacher
    assert_equal studier.student.full_name, studier.full_name
    assert_equal studier.student.email, studier.email
  end
end