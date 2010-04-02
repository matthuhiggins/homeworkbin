require 'active_record_test'

class PersonTest < ActiveRecord::TestCase
  include ActiveRecord::AuthenticatedTests
  include ActiveRecord::EmailValidationTests
  
  def test_teacher
    assert_kind_of Teacher, Factory.build(:person).teacher
  end
  
  def test_student
    assert_kind_of Student, Factory.build(:person).student
  end
  
  def test_validate_presence_of_password
    person = Factory :person

    person.update_attributes(:password => nil)
    assert_nil person.errors.on(:password)
    
    person.update_attributes(:password => '')
    assert_equal "can't be blank", person.errors.on(:password)
  end
end