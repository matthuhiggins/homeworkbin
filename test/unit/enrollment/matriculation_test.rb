require 'active_record_test'

class Enrollment::MatriculationTest < ActiveRecord::TestCase
  include ActionMailer::TestHelper

  test 'matriculate emails' do
    course = Factory.course.create
    
    enrollments = course.enrollments.matriculate_emails 'a@b.com,x@y.com f@g.com;m@n.com'
    
    assert_equal 4, enrollments.size
  end
  
  test 'matriculate new email' do
    course = Factory.course.create
    
    enrollment = course.enrollments.matriculate_email 'a@b.com'
    assert !enrollment.new_record?
    assert_equal 'a@b.com', enrollment.email
  end
  
  test 'matriculate existing email' do
    course = Factory.course.create
    existing_enrollment = factory.create course: course

    assert_emails 1 do
      new_enrollment = course.enrollments.matriculate_email existing_enrollment.email
      assert_equal existing_enrollment, new_enrollment
    end
  end
  
  test 'matriculate invalid email' do
    course = Factory.course.create

    assert_no_emails do
      enrollment = course.enrollments.matriculate_email 'x'
      assert enrollment.new_record?
    end
  end
end