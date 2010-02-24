require 'active_record_test'

class PersonTest < ActiveRecord::TestCase
  include ActiveRecord::AuthenticatedTests
  include ActiveRecord::EmailValidationTests
  
  def test_teaching?
    assert !Factory(:person).teaching?
    assert !Factory(:student).teaching?
    assert Factory(:teacher).teaching?
  end
  
  def test_studying?
    student = Factory :student
    assert !student.studying?
    
    student.studying << Factory(:course)

    assert student.studying?
  end
  
  def test_validate_presence_of_password
    person = Factory :person

    person.update_attributes(:password => nil)
    assert_nil person.errors.on(:password)
    
    person.update_attributes(:password => '')
    assert_equal "can't be blank", person.errors.on(:password)
  end
end