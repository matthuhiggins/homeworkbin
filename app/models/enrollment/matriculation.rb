class Enrollment
  module Matriculation
    def matriculate_emails(emails)
      emails.split(/[\s,;]+/).map do |email|
        matriculate_email email
      end
    end
  
    def matriculate_email(email)
      enrollment = find_or_create_by_email(email)
      Mailer.deliver_enrollment enrollment
      enrollment
    end
  end
end