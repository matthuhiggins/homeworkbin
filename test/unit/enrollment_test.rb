require 'active_record_test'

class EnrollmentTest < ActiveSupport::TestCase
  include ActiveRecord::TokenizedTests
  include ActiveRecord::EmailValidationTests
  
  def test_teaching_delegation
    enrollment = Factory :enrollment
    assert_equal enrollment.course.teacher, enrollment.teacher
  end
  
  def test_student_already_studying
    course = Factory :course
    student = Factory :student
    course.students << student
    
    enrollment = Factory.build :enrollment, :course => course, :email => student.email
    
    assert enrollment.invalid?
    assert_equal 'is already in this course', enrollment.errors.on(:email)
  end
  
  def test_nil_student
    enrollment = Factory :enrollment
    student = enrollment.student

    assert student.new_record?
    assert_equal enrollment.email, student.email
  end
  
  def test_existing_student
    student = Factory :student
    assert_equal student, Factory.build(:enrollment, :email => student.email).student
  end
  
  def test_new_student?
    assert Factory.build(:enrollment).new_student?
    assert !Factory.build(:enrollment, :email => Factory(:student).email).new_student?
  end
  
  def test_
    
  end
end