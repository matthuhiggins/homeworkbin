require 'test_helper'

class InvitationTest < ActiveSupport::TestCase
  include Concerns::TokenizedTests
  include Concerns::EmailValidationTests
  
  def test_nil_student
    assert_nil Factory.build(:invitation).student
  end
  
  def test_existing_student
    student = Factory :student
    assert_equal student, Factory.build(:invitation, :email => student.email).student
  end
  
  def test_mail
    assert_emails 1 do
      Factory :invitation
    end
  end
end