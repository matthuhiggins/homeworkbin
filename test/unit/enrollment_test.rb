require 'test_helper'

class EnrollmentTest < ActiveSupport::TestCase
  include Concerns::TokenizedTests
  include Concerns::EmailValidationTests
  
  def test_nil_student
    assert_nil Factory.build(:enrollment).student
  end
  
  def test_existing_student
    student = Factory :student
    assert_equal student, Factory.build(:enrollment, :email => student.email).student
  end
  
  def test_mail
    assert_emails 1 do
      Factory :enrollment
    end
  end
end