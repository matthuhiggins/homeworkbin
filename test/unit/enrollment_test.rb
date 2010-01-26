require 'test_helper'

class EnrollmentTest < ActiveSupport::TestCase
  include Concerns::TokenizedTests
  include Concerns::EmailValidationTests
  
  def test_teacher_delegation
    enrollment = Factory :enrollment
    assert_equal enrollment.course.teacher, enrollment.teacher
  end
  
  def test_nil_student
    assert_nil Factory.build(:enrollment).student
  end
  
  def test_existing_student
    student = Factory :student
    assert_equal student, Factory.build(:enrollment, :email => student.email).student
  end
  
  def test_test_new_student?
    assert Factory.build(:enrollment).new_student?
    assert !Factory.build(:enrollment, :email => Factory(:student).email).new_student?
  end
end