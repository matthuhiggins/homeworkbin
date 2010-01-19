require 'test_helper'

class PersonTest < ActiveSupport::TestCase
  include Concerns::EmailValidationTests
  
  def test_teacher?
    teacher = Factory :teacher
    assert !teacher.teacher?

    teacher.courses.create Factory.attributes_for(:course)
    teacher.reload
    assert teacher.teacher?
  end
  
  def test_student?
    student = Factory :student
    course = Factory :course
    assert !student.student?
    
    student.courses << course
    student.reload
    assert student.student?
  end
end