class Mailer < ActionMailer::Base
  def registration registration
    from        "no-reply@homeworkbin.com"
    recipients  registration.email
    subject     'Confirm your email address'
    body        :registration => registration
  end
  
  def enrollment enrollment
    from        "no-reply@homeworkbin.com"
    recipients  enrollment.email
    subject     "Confirm your enrollment in #{enrollment.course.name}"
    body        :enrollment => enrollment
  end
  
  def lost_password lost_password
    from        "no-reply@homeworkbin.com"
    recipients  lost_password.person.email
    subject     "Homework Bin password change"
    body        :lost_password => lost_password
  end
  
  def assignment assignment, student
    from        "no-reply@homeworkbin.com"
    recipients  student.email
    subject     "New assignment in #{assignment.course.name}"
    body        :assignment => assignment, :student => student
  end
  
  def studier studier
    from        "no-reply@homeworkbin.com"
    recipients  studier.student.email
    subject     "You are enrolled in #{studier.course.name}"
    body        :studier => studier
  end
end