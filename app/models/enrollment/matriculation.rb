class Enrollment
  module Matriculation
    def matriculate_emails(emails)
      emails.split(/[\s,;]+/).map do |email|
        matriculate_email email
      end
    end
  
    def matriculate_email(email)
      if enrollment = find_by_email(email)
        Mailer.enrollment(enrollment).deliver
      else
        enrollment = create(email: email)
      end

      enrollment
    end
  end
end