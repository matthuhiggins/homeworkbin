require 'test_helper'

class LostPasswordTest < ActiveSupport::TestCase
  include Concerns::TokenizedTests
  include Concerns::EmailValidationTests

  def test_unknown_email
    lost_password = Factory.build :lost_password, :email => 'joe@spu.edu'
    
    assert lost_password.invalid?
    assert_equal 'does not exist', lost_password.errors.on(:email)
  end
  
  def test_email_rejected_during_update
    lost_password = Factory :lost_password
    
    assert_raise(RuntimeError) { lost_password.email = 'foo@bar.com' }
  end
  
  def test_person
    person = Factory :person, :email => 'joe@spu.edu'
    lost_password = Factory.build :lost_password, :email => person.email
    
    assert_equal person, lost_password.person
  end
  
  def test_email
    person = Factory :person, :email => 'joe@spu.edu'
  
    assert_emails 1 do
      Factory :lost_password, :email => person.email
    end
  end
  
  def test_new_password_rejected_during_create
    lost_password = Factory.build :lost_password

    assert_raise(RuntimeError) { lost_password.new_password = 'wtf' }
  end
  
  def test_empty_password_invalid
    lost_password = Factory :lost_password
    
    lost_password.new_password = ''
    
    assert lost_password.invalid?
    assert_equal "can't be blank", lost_password.errors.on(:new_password)
  end
  
  def test_new_password
    lost_password = Factory :lost_password

    lost_password.update_attribute :new_password, 'sshh'
    
    assert_raises(ActiveRecord::RecordNotFound) { lost_password.reload }
    assert lost_password.person.authenticate('sshh')
  end
end