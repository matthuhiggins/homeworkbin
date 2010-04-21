class Mailer < ActionMailer::Base
  helper ActionController::Base.send(:all_application_helpers)
  default from: 'no-reply@homeworkbin.com'
  
  def registration registration
    @registration = registration  
    
    mail(
      to:     registration.email,
      subject: 'Confirm your email address'
    )
  end
  
  def enrollment enrollment
    @enrollment = enrollment

    mail(
      to:       enrollment.email,
      subject:  "Confirm your enrollment in #{enrollment.course.name}"
    )
  end
  
  def lost_password lost_password
    @lost_password = lost_password

    mail(
      recipients:  lost_password.person.email,
      subject:     "Homework Bin password change"
    )
  end
  
  def assignment assignment, student
    @assignment = assignment
    @student    = student

    mail(
      :to       => student.email,
      :subject  => "New assignment in #{assignment.course.name}"
    )
  end
  
  def studier studier
    @studier = studier

    mail(
      :to       => studier.email,
      :subject  => "You are enrolled in #{studier.course.name}"
    )
  end
end