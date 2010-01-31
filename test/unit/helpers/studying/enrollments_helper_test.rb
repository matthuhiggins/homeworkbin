require 'action_view_test'

class Studying::EnrollmentsHelperTest < ActionView::TestCase
  def test_fields_partial_for_new_student
    enrollment = Factory :enrollment
    assert_equal 'new_student', enrollment_fields_partial(enrollment)
  end
  
  def test_fields_partial_for_existing_student
    enrollment = Factory :enrollment, :email => Factory(:person).email
    assert_equal 'existing_student', enrollment_fields_partial(enrollment)    
  end
end