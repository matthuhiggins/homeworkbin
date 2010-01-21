module MailerHelper
  def determine_enrollment_partial(enrollment)
    @enrollment.test_new_student? ? 'mailer/enrollment/new_student' : 'mailer/enrollment/existing_student'
  end
end