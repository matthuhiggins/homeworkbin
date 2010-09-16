require 'action_view_test'

class MailerHelperTest < ActionView::TestCase
  test 'determine_enrollment_partial' do
    assert_equal(
      'mailer/enrollment/new_student',
      determine_enrollment_partial(Factory.enrollment.build)
    )
    assert_equal(
      'mailer/enrollment/existing_student',
      determine_enrollment_partial(Factory.enrollment.build email: Factory.person.create.email)
    )
  end
end