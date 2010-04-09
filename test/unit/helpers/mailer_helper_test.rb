require 'action_view_test'

class MailerHelperTest < ActionView::TestCase
  def test_determine_enrollment_partial
    assert_equal(
      'mailer/enrollment/new_student',
      determine_enrollment_partial(Factory.enrollment.build)
    )
    assert_equal(
      'mailer/enrollment/existing_student',
      determine_enrollment_partial(Factory.enrollment.build :email => Factory.person.build.email)
    )
  end
end