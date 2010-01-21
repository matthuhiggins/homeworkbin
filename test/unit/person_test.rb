require 'test_helper'

class PersonTest < ActiveSupport::TestCase
  include Concerns::EmailValidationTests
  
  def test_teaching?
    assert !Factory(:person).teaching?
    assert !Factory(:student).teaching?
    assert Factory(:teacher).teaching?
  end
  
  def test_studying?
    student = Factory :student
    assert !student.studying?
    
    student.studying << Factory(:course)
    student.reload
    assert student.studying?
  end
end