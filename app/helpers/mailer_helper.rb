module MailerHelper
  def determine_enrollment_partial(enrollment)
    @enrollment.new_studying? ? 'mailer/enrollment/new_student' : 'mailer/enrollment/existing_student'
  end
end