require 'active_record_test'

class EnrollmentTest < ActiveSupport::TestCase
  include ActiveRecord::TokenizedTests
  include ActiveRecord::EmailValidationTests
  
  def test_teaching_delegation
    enrollment = Factory :enrollment
    assert_equal enrollment.course.teacher, enrollment.teacher
  end
  
  def test_validate_existing_studier
    course = Factory :course
    student = Factory :student
    course.students << student
    
    enrollment = Factory.build :enrollment, :course => course, :email => student.email
    
    assert enrollment.invalid?
    assert_equal 'is already in this course', enrollment.errors.on(:email)
  end
  
  def test_validate_student
    enrollment = Factory :enrollment
    
    enrollment.student = {:email => 'poo'}
    
    assert enrollment.invalid?
    assert_equal 'is invalid', enrollment.errors.on(:student)
  end
  
  def test_empty_student
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
  
  def test_enroll_student
    student = Factory :student, :automatically_enroll => false
    enrollment = Factory :enrollment, :email => student.email
    
    studier = enrollment.enroll_student!
    
    assert_kind_of Studier, studier
    assert enrollment.course.students.include?(student)
    assert_raises ActiveRecord::RecordNotFound do
      enrollment.reload
    end
  end
  
  def test_enabled_automatic_enrollment
    student = Factory :student, :automatically_enroll => true

    assert_emails 1 do
      enrollment = Factory :enrollment, :email => student.email
      assert enrollment.course.students.include?(student)
    end
  end
  
  def test_disabled_automatic_enrollment
    student = Factory :student, :automatically_enroll => false
    
    assert_emails 1 do
      enrollment = Factory :enrollment, :email => student.email
      assert !enrollment.course.students.include?(student)
    end
  end
  
  def test_new_student_accepts_enrollment
    enrollment = Factory :enrollment
    
    enrollment.update_attributes(
      :student            => Factory.attributes_for(:student),
      :accept_enrollment  => true
    )
    
    assert !enrollment.student.new_record?
    assert enrollment.course.students.include?(enrollment.student)
  end
  
  def test_existing_student_accepts_enrollment
    student = Factory :student, :automatically_enroll => false
    enrollment = Factory :enrollment, :email => student.email
    
    enrollment.update_attributes :accept_enrollment => true
    
    assert enrollment.course.students.include?(enrollment.student)
  end
end