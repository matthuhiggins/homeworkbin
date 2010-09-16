require 'active_record_test'

class Person::RememberedTest < ActiveRecord::TestCase
  test 'remember_me' do
    person = factory.create
    assert_nil person.remember_token

    person.remember_me!

    assert_not_nil person.remember_token
    assert !person.changed?
  end
  
  test 'forget_me' do
    person = factory.create remember_token: "big_sekret"

    person.forget_me!

    assert_nil person.remember_token
    assert !person.changed?
  end
end