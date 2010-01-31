require 'active_record_test'

class Enrollment::MatriculationTest < ActiveSupport::TestCase
  def test_matriculate_emails
    course = Factory :course
    
    enrollments = course.enrollments.matriculate_emails 'a@b.com,x@y.com f@g.com;m@n.com'
    
    assert_equal 4, enrollments.size
  end
  
  def test_matriculate_new_email
    course = Factory :course
    
    enrollment = course.enrollments.matriculate_email 'a@b.com'
    assert !enrollment.new_record?
    assert_equal 'a@b.com', enrollment.email
  end
  
  def test_matriculate_existing_email
    course = Factory :course
    existing_enrollment = Factory :enrollment, :course => course

    assert_emails 1 do
      new_enrollment = course.enrollments.matriculate_email existing_enrollment.email
      assert_equal existing_enrollment, new_enrollment
    end
  end
  
  def test_matriculate_invalid_email
    course = Factory :course

    assert_no_emails do
      enrollment = course.enrollments.matriculate_email 'x'
      assert enrollment.new_record?
    end
  end
end