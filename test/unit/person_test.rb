require 'active_record_test'

class PersonTest < ActiveRecord::TestCase
  include ActiveRecord::AuthenticatedTests
  include ActiveRecord::EmailValidationTests
  
  test 'teacher' do
    assert_kind_of Teacher, factory.build.teacher
  end
  
  test 'student' do
    assert_kind_of Student, factory.build.student
  end
  
  test 'validate presence of password' do
    person = factory.create

    person.update_attributes(password: nil)
    assert person.errors[:password].empty?
    
    person.update_attributes(password: '')
    assert person.errors[:password].include?("can't be blank")
  end
end