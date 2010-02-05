require 'active_record_test'

class CourseTest < ActiveSupport::TestCase
  extend ActiveRecord::DateValidationTests
  test_date_format_validation :start_date, :end_date
  
  def test_create_course_decrements_courses_available
    teacher = Factory :teacher
    assert_equal 1, teacher.courses_available
    
    Factory :course, :teacher => teacher
    
    assert_equal 0, teacher.courses_available
  end
  
  def test_date_format_validation
    [:start_date, :end_date].each do |attribute|
      check_invalid_dates attribute
      check_valid_dates attribute
    end
  end
  
  private
    def check_invalid_dates(attribute)
      course = Factory.build :course

      ['', nil, '12/40/2004', '12/25', '10-2004'].each do |value|
        course[attribute] = value
        assert course.invalid?
        assert_equal 'must be mm/dd/yyyy', course.errors.on(attribute)
      end
    end
    
    def check_valid_dates(attribute)
      course = Factory.build :course

      ['jun 5 2003', '12/20/2004', '2/2/2003'].each do |value|
        course[attribute] = value
        assert course.valid?
      end
    end
end