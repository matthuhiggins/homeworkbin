require 'active_record_test'

class StudentTest < ActiveRecord::TestCase
  test 'enrollments' do
    other_enrollment = Factory.enrollment.create email: 'other@foo.bar'
    my_enrollment = Factory.enrollment.create email: 'me@matthewhiggins.com'
    student = factory.create email: 'me@matthewhiggins.com'
    
    assert_equal [my_enrollment], student.enrollments
  end
end