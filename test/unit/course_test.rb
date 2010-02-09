require 'active_record_test'

class CourseTest < ActiveSupport::TestCase
  include ActiveRecord::DateValidationTests
  test_date_format_validation :start_date, :end_date

  def test_create_course_decrements_courses_available
    teacher = Factory :teacher
    assert_equal 1, teacher.courses_available
    
    Factory :course, :teacher => teacher
    
    assert_equal 0, teacher.courses_available
  end
end