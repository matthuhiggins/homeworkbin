class Mailer < ActionMailer::Base
  def registration registration
    recipients  registration.email
    subject     'Confirm your email address'
    body        :registration => registration
  end
  
  def invitation invitation
    recipients  invitation.email
    subject     "#{invitation.teacher} invited you to #{invitation.course}"
    body        :invitation => invitation
  end
  
  def lost_password lost_password
    recipients  lost_password.person.email
    subject     "Create your new password"
    body        :lost_password => lost_password
  end
  
  def assignment assignment, student
    recipients  student.email
    subject     "There's a new assignment in #{assignment.course.name}"
    body        :assignment => assignment, :student => student
  end
end