require 'active_record_test'

class Person::RememberedTest < ActiveRecord::TestCase
  def test_remember_me
    person = Factory :person
    assert_nil person.remember_token

    person.remember_me!

    assert_not_nil person.remember_token
    assert !person.changed?
  end
  
  def test_forget_me
    person = Factory :person, :remember_token => "big_sekret"

    person.forget_me!

    assert_nil person.remember_token
    assert !person.changed?
  end
end