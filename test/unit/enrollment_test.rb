require 'active_record_test'

class EnrollmentTest < ActiveRecord::TestCase
  include ActiveRecord::TokenizedTests
  include ActiveRecord::EmailValidationTests
  
  def test_teaching_delegation
    enrollment = factory.create
    assert_equal enrollment.course.teacher, enrollment.teacher
  end
  
  def test_validate_existing_studier
    course = Factory.course.create
    student = Factory.student.create
    course.students << student
    
    enrollment = factory.build :course => course, :email => student.email
    
    assert enrollment.invalid?
    assert_equal ['is already in this course'], enrollment.errors[:email]
  end
  
  def test_validate_student
    enrollment = factory.create
    
    enrollment.student = {:email => 'poo'}
    
    assert enrollment.invalid?
    assert_equal ['is invalid'], enrollment.errors[:student]
  end
  
  def test_empty_student
    enrollment = factory.create
    student = enrollment.student

    assert student.new_record?
    assert_equal enrollment.email, student.email
  end
  
  def test_existing_student
    student = Factory.student.create
    assert_equal student, factory.build(:email => student.email).student
  end
  
  def test_new_student?
    assert factory.build.new_student?
    assert !factory.build(:email => Factory.student.build.email).new_student?
  end
  
  def test_enroll_student
    student = Factory.student.create :automatically_enroll => false
    enrollment = factory.create :email => student.email
    
    studier = enrollment.enroll_student!
    
    assert_kind_of Studier, studier
    assert enrollment.course.students.include?(student)
    assert_destroyed enrollment
  end
  
  def test_enabled_automatic_enrollment
    student = Factory.student.create :automatically_enroll => true

    assert_emails 1 do
      enrollment = factory.create :email => student.email
      assert enrollment.course.students.include?(student)
    end
  end
  
  def test_disabled_automatic_enrollment
    student = Factory.student.create :automatically_enroll => false
    
    assert_emails 1 do
      enrollment = factory.create :email => student.email
      assert !enrollment.course.students.include?(student)
    end
  end
  
  def test_new_student_accepts_enrollment
    enrollment = factory.create
    
    enrollment.update_attributes(
      :student            => Factory.student.attributes,
      :accept_enrollment  => true
    )
    
    assert !enrollment.student.new_record?
    assert enrollment.course.students.include?(enrollment.student)
  end
  
  def test_existing_student_accepts_enrollment
    student = Factory.student.create :automatically_enroll => false
    enrollment = factory.create :email => student.email
    
    enrollment.update_attributes :accept_enrollment => true
    
    assert enrollment.course.students.include?(enrollment.student)
  end
end