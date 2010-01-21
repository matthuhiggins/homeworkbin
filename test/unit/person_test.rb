require 'test_helper'

class PersonTest < ActiveSupport::TestCase
  include Concerns::EmailValidationTests
  
  def test_teacher?
    assert !Factory(:person).teacher?
    assert !Factory(:student).teacher?
    assert Factory(:teacher).teacher?
  end
  
  def test_student?
    student = Factory :student
    assert !student.student?
    
    student.studying << Factory(:course)
    student.reload
    assert student.student?
  end
end