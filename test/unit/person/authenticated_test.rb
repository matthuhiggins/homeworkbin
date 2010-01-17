require 'test_helper'

class Person::AuthenticatedTest < ActiveSupport::TestCase
  def test_authenticate
    person = Factory :person
    
    assert_nil Person.authenticate person.email, 'incorrect'
    assert_equal person, Person.authenticate(person.email, Factory.attributes_for(:person)[:password])

    assert !person.authenticate('incorrect')
    assert person.authenticate(Factory.attributes_for(:person)[:password])
  end
  
  def test_password_confirmation_on_create
    person = Factory.build :person, :password => 'foo', :password_confirmation => 'bar'
    
    assert person.invalid?
    assert_equal "doesn't match confirmation", person.errors.on(:password)
  end
  
  def test_update_password
    person = Factory :person

    assert person.update_attribute(:password, 'omg')
    assert person.authenticate('omg')
  end
end