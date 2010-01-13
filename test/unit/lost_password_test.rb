require 'test_helper'

class LostPasswordTest < ActiveSupport::TestCase
  def test_unknown_email
    lost_password = Factory.build :lost_password, :email => 'joe@spu.edu'
    
    assert lost_password.invalid?
    assert_equal 'does not exist', lost_password.errors.on(:email)
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
end