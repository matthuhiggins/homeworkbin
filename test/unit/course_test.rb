require 'active_record_test'

class CourseTest < ActiveRecord::TestCase
  include ActiveRecord::DateValidationTests
  tests_date_format_validation :start_date, :end_date
  
  test 'create decrements courses available' do
    teacher = Factory.teacher.create
    assert_equal 1, teacher.courses_available
    
    factory.create teacher: teacher
    
    assert_equal 0, teacher.courses_available
  end

  test 'create increments courses created' do
    teacher = Factory.teacher.create
    assert_equal 0, teacher.courses_created

    factory.create teacher: teacher
    
    assert_equal 1, teacher.courses_created
  end

  test 'last' do
    teacher = Factory.teacher.create
    first_course = factory.create teacher: teacher
    second_course = factory.create teacher: teacher
    new_course = factory.build teacher: teacher
    
    assert_equal second_course, new_course.last
  end
end