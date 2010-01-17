class Mailer < ActionMailer::Base
  def registration registration
    recipients  registration.email
    subject     'Confirm your email address'
    body        :registration => registration
  end
  
  def enrollment enrollment
    recipients  enrollment.email
    subject     "Confirm your enrollment in #{enrollment.course.name}"
    body        :enrollment => enrollment
  end
  
  def lost_password lost_password
    recipients  lost_password.person.email
    subject     "Homework Bin password change"
    body        :lost_password => lost_password
  end
  
  def assignment assignment, student
    recipients  student.email
    subject     "There's a new assignment in #{assignment.course.name}"
    body        :assignment => assignment, :student => student
  end
end