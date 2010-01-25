class Mailer < ActionMailer::Base
  def registration registration
    from        "<no-reply@homeworkbin.com"
    recipients  registration.email
    subject     'Confirm your email address'
    body        :registration => registration
  end
  
  def enrollment enrollment
    from        %{"Homework Bin" <no-reply@homeworkbin.com>}
    recipients  enrollment.email
    subject     "Confirm your enrollment in #{enrollment.course.name}"
    body        :enrollment => enrollment
  end
  
  def lost_password lost_password
    from        %{"Homework Bin" <no-reply@homeworkbin.com>}
    recipients  lost_password.person.email
    subject     "Homework Bin password change"
    body        :lost_password => lost_password
  end
  
  def assignment assignment, student
    # from        %{"Homework Bin" <no-reply@homeworkbin.com>}
    from        "<no-reply@homeworkbin.com"
    recipients  student.email
    subject     "New assignment in #{assignment.course.name}"
    body        :assignment => assignment, :student => student
  end
end