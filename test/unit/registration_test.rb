require 'test_helper'

class RegistrationTest < ActiveSupport::TestCase
  include Concerns::TokenizedTests
  include Concerns::EmailValidationTests
  
  def test_mail
    assert_emails 1 do
      Factory :registration
    end
  end
  
  def test_existing_person
    person = Factory :person
    
    existing_person = Factory.build :registration, :email => person.email
    assert existing_person.invalid?
    assert_equal 'is already in use', existing_person.errors.on(:email)
    
    new_person = Factory.build :registration
    assert new_person.valid?
  end
  
  def test_build_teacher
    registration = Factory.build :registration
    
    teacher = registration.build_teacher
    
    assert teacher.new_record?
    assert_equal registration.full_name, teacher.full_name
    assert_equal registration.email, teacher.email
  end
end