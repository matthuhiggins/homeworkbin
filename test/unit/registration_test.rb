require 'active_record_test'

class RegistrationTest < ActiveRecord::TestCase
  include ActiveRecord::TokenizedTests
  include ActiveRecord::EmailValidationTests
  include ActiveRecord::AuthenticatedTests
  include ActionMailer::TestHelper

  test 'mail' do
    assert_emails 1 do
      factory.create
    end
  end
  
  test 'validate existing person' do
    person = Factory.person.create
    
    existing_person = factory.build email: person.email
    assert existing_person.invalid?
    assert_equal ['is already in use'], existing_person.errors[:email]
    
    new_person = factory.build
    assert new_person.valid?
  end
  
  test 'validate presence' do
    registration = factory.build full_name: '', password: ''
    assert registration.invalid?
    assert_equal ["can't be blank"], registration.errors[:full_name]
    assert_equal ["can't be blank"], registration.errors[:password]
  end
  
  test 'create_teacher copies attributes' do
    registration = factory.create
    
    teacher = registration.create_teacher!
    
    assert !teacher.new_record?
    assert_equal registration.full_name, teacher.full_name
    assert_equal registration.email, teacher.email
    assert_equal registration.salt, teacher.salt
    assert_equal registration.encrypted_password, teacher.encrypted_password
  end
  
  test 'create_teacher destroys related registrations' do
    primary_registration = factory.create email: 'a@b.com'
    duplicate_registration = factory.create email: 'a@b.com'
    other_registration = factory.create email: 'x@y.com'
    
    primary_registration.create_teacher!
    
    assert_destroyed primary_registration
    assert_destroyed duplicate_registration
    assert_not_destroyed other_registration
  end
end