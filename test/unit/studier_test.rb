require 'active_record_test'

class StudierTest < ActiveSupport::TestCase
  def test_teacher_delegation
    studier = Factory :studier
    assert_equal studier.course.teacher, studier.teacher
  end
end