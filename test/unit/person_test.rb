require 'active_record_test'

class PersonTest < ActiveRecord::TestCase
  include ActiveRecord::AuthenticatedTests
  include ActiveRecord::EmailValidationTests
  
  def test_teacher
    assert_kind_of Teacher, factory.build.teacher
  end
  
  def test_student
    assert_kind_of Student, factory.build.student
  end
  
  def test_validate_presence_of_password
    person = factory.create

    person.update_attributes(:password => nil)
    assert person.errors[:password].empty?
    
    person.update_attributes(:password => '')
    assert person.errors[:password].include?("can't be blank")
  end
end