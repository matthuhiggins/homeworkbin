require 'active_record_test'

class CourseTest < ActiveRecord::TestCase
  include ActiveRecord::DateValidationTests
  test_date_format_validation :start_date, :end_date
  
  def test_create_decrements_courses_available
    teacher = Factory.teacher.create
    assert_equal 1, teacher.courses_available
    
    factory.create :teacher => teacher
    
    assert_equal 0, teacher.courses_available
  end

  def test_create_increments_courses_created
    teacher = Factory.teacher.create
    assert_equal 0, teacher.courses_created

    factory.create :teacher => teacher
    
    assert_equal 1, teacher.courses_created
  end

  def test_last
    teacher = Factory.teacher.create
    first_course = factory.create :teacher => teacher
    second_course = factory.create :teacher => teacher
    new_course = factory.build :teacher => teacher
    
    assert_equal second_course, new_course.last
  end
  
  def test_date_range
    course = factory.create :start_date => '12/25/2004', :end_date => '2/20/2005'
    
    assert_equal Date.new(2004, 12, 25)..Date.new(2005, 2, 20), course.date_range
  end
end