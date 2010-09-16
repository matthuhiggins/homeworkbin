require 'action_view_test'

class EnrollmentsHelperTest < ActionView::TestCase
  test 'fields_partial_for_new_student' do
    enrollment = Factory.enrollment.create
    assert_equal 'new_student', enrollment_fields_partial(enrollment)
  end
  
  test 'fields_partial_for_existing_student' do
    enrollment = Factory.enrollment.create email: Factory.person.create.email
    assert_equal 'existing_student', enrollment_fields_partial(enrollment)    
  end
end