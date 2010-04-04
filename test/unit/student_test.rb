require 'active_record_test'

class StudentTest < ActiveRecord::TestCase
  def test_enrollments
    other_enrollment = Factory :enrollment, :email => 'other@foo.bar'
    my_enrollment = Factory :enrollment, :email => 'me@matthewhiggins.com'
    student = Factory :student, :email => 'me@matthewhiggins.com'
    
    assert_equal [my_enrollment], student.enrollments
  end
end