require 'active_record_test'

class TeacherTest < ActiveRecord::TestCase
  test 'courses_available default' do
    assert_equal 1, factory.create.courses_available
  end
  
  test 'registered_as_teacher default' do
    assert factory.create.registered_as_teacher
  end
end