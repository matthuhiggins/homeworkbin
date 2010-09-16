require 'active_record_test'

class EnrollmentTest < ActiveRecord::TestCase
  include ActiveRecord::TokenizedTests
  include ActiveRecord::EmailValidationTests
  include ActionMailer::TestHelper
  
  test 'teaching delegation' do
    enrollment = factory.create
    assert_equal enrollment.course.teacher, enrollment.teacher
  end
  
  test 'validate existing studier' do
    course = Factory.course.create
    student = Factory.student.create
    course.students << student
    
    enrollment = factory.build course: course, email: student.email
    
    assert enrollment.invalid?
    assert_equal ['is already in this course'], enrollment.errors[:email]
  end
  
  test 'validate student' do
    enrollment = factory.create
    
    enrollment.student = {email: 'poo'}
    
    assert enrollment.invalid?
    assert_equal ['is invalid'], enrollment.errors[:student]
  end
  
  test 'empty student' do
    enrollment = factory.create
    student = enrollment.student

    assert student.new_record?
    assert_equal enrollment.email, student.email
  end
  
  test 'existing student' do
    student = Factory.student.create
    assert_equal student, factory.build(email: student.email).student
  end
  
  test 'new student?' do
    assert factory.build.new_student?
    assert !factory.build(email: Factory.student.create.email).new_student?
  end
  
  test 'enroll_student' do
    student = Factory.student.create automatically_enroll: false
    enrollment = factory.create email: student.email
    
    studier = enrollment.enroll_student!
    
    assert_kind_of Studier, studier
    assert enrollment.course.students.include?(student)
    assert_destroyed enrollment
  end
  
  test 'enabled automatic enrollment' do
    student = Factory.student.create automatically_enroll: true

    assert_emails 1 do
      enrollment = factory.create email: student.email
      assert enrollment.course.students.include?(student)
    end
  end
  
  test 'disabled automatic enrollment' do
    student = Factory.student.create automatically_enroll: false
    
    assert_emails 1 do
      enrollment = factory.create email: student.email
      assert !enrollment.course.students.include?(student)
    end
  end
  
  test 'new student accepts enrollment' do
    enrollment = factory.create
    
    enrollment.update_attributes(
      :student            => Factory.student.attributes,
      :accept_enrollment  => true
    )
    
    assert !enrollment.student.new_record?
    assert enrollment.course.students.include?(enrollment.student)
  end
  
  test 'existing student accepts enrollment' do
    student = Factory.student.create automatically_enroll: false
    enrollment = factory.create email: student.email
    
    enrollment.update_attributes accept_enrollment: true
    
    assert enrollment.course.students.include?(enrollment.student)
  end
end