class Enrollment
  module Matriculation
    def matriculate_emails(emails)
      emails.split(/[\s,;]+/).map do |email|
        matriculate_email email
      end
    end
  
    def matriculate_email(email)
      find_or_create_by_email(email).tap do |enrollment|
        if enrollment.valid?
          Mailer.deliver_enrollment enrollment
        end
      end
    end
  end
end