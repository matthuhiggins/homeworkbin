require 'test_helper'

class PersonTest < ActiveSupport::TestCase
  include Concerns::EmailValidationTests
  
  def test_teacher?
    teacher = Factory :teacher
    assert !teacher.teacher?

    Factory :course, :teacher => teacher
    teacher.reload
    assert teacher.teacher?
  end
  
  def test_student?
    student = Factory :student
    assert !student.student?
    
    student.studying << Factory(:course)
    student.reload
    assert student.student?
  end
end