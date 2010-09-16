require 'active_record_test'

class LostPasswordTest < ActiveRecord::TestCase
  include ActiveRecord::TokenizedTests
  include ActionMailer::TestHelper

  test 'unknown email' do
    lost_password = Factory.lost_password.build email: 'joe@spu.edu'
    
    assert lost_password.invalid?
    assert_equal ['does not exist'], lost_password.errors[:email]
  end
  
  test 'email rejected during update' do
    lost_password = Factory.lost_password.create
    
    assert_raise(RuntimeError) { lost_password.email = 'foo@bar.com' }
  end
  
  test 'person' do
    person = Factory.person.create email: 'joe@spu.edu'
    lost_password = Factory.lost_password.build email: person.email
    
    assert_equal person, lost_password.person
  end
  
  test 'email' do
    person = Factory.person.create email: 'joe@spu.edu'
  
    assert_emails 1 do
      Factory.lost_password.create email: person.email
    end
  end
  
  test 'new_password rejected during create' do
    lost_password = Factory.lost_password.build

    assert_raise(RuntimeError) { lost_password.new_password = 'wtf' }
  end
  
  test 'empty password invalid' do
    lost_password = Factory.lost_password.create
    
    lost_password.new_password = ''
    
    assert lost_password.invalid?
    assert_equal ["can't be blank"], lost_password.errors[:new_password]
  end
  
  test 'new_password' do
    lost_password = Factory.lost_password.create

    lost_password.update_attribute :new_password, 'sshh'
    
    assert_destroyed lost_password
    assert lost_password.person.authenticate('sshh')
  end
end