require 'action_view_test'

class MailerHelperTest < ActionView::TestCase
  def test_determine_enrollment_partial
    assert_equal(
      'mailer/enrollment/new_student',
      determine_enrollment_partial(Factory.build :enrollment)
    )
    assert_equal(
      'mailer/enrollment/existing_student',
      determine_enrollment_partial(Factory.build :enrollment, :email => Factory(:person).email)
    )
  end
end