require 'active_record_test'

class RegistrationTest < ActiveSupport::TestCase
  include ActiveRecord::TokenizedTests
  include ActiveRecord::EmailValidationTests
  include ActiveRecord::AuthenticatedTests
  
  def test_mail
    assert_emails 1 do
      Factory :registration
    end
  end
  
  def test_validate_existing_person
    person = Factory :person
    
    existing_person = Factory.build :registration, :email => person.email
    assert existing_person.invalid?
    assert_equal 'is already in use', existing_person.errors.on(:email)
    
    new_person = Factory.build :registration
    assert new_person.valid?
  end
  
  def test_validate_presence
    registration = Factory.build :registration, :full_name => '', :password => ''
    assert registration.invalid?
    assert_equal "can't be blank", registration.errors.on(:full_name)
    assert_equal "can't be blank", registration.errors.on(:password)
  end
  
  def test_create_teacher_copies_attributes
    registration = Factory :registration
    
    teacher = registration.create_teacher!
    
    assert !teacher.new_record?
    assert_equal registration.full_name, teacher.full_name
    assert_equal registration.email, teacher.email
    assert_equal registration.salt, teacher.salt
    assert_equal registration.encrypted_password, teacher.encrypted_password
  end
  
  def test_create_teaching_destroys_related_registrations
    primary_registration = Factory :registration, :email => 'a@b.com'
    duplicate_registration = Factory :registration, :email => 'a@b.com'
    other_registration = Factory :registration, :email => 'x@y.com'
    
    primary_registration.create_teacher!
    
    assert_raise(ActiveRecord::RecordNotFound) { primary_registration.reload }
    assert_raise(ActiveRecord::RecordNotFound) { duplicate_registration.reload }
    assert_nothing_raised { other_registration.reload }
  end
end