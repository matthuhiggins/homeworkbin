require 'active_record_test'

class MailerTest < ActionMailer::TestCase
  def test_registration
    registration = Factory.registration.create

    with_mail :registration, registration do |sent|
      assert_equal 'Confirm your email address', sent.subject
      assert_equal [registration.email], sent.to
      assert_match registration.token, sent.body
    end
  end
  
  def test_enrollment
    enrollment = Factory.enrollment.create

    with_mail :enrollment, enrollment do |sent|
      assert_equal "Confirm your enrollment in #{enrollment.course.name}", sent.subject
      assert_equal [enrollment.email], sent.to
      assert_match enrollment.token, sent.body
    end
  end

  def test_lost_password
    lost_password = Factory.lost_password.create

    with_mail :lost_password, lost_password do |sent|
      assert_equal "Homework Bin password change", sent.subject
      assert_equal [lost_password.person.email], sent.to
      assert_match lost_password.token, sent.body
    end
  end
  
  def test_studier
    studier = Factory.studier.build
    
    with_mail :studier, studier do |sent|
      assert_equal "You are enrolled in #{studier.course.name}", sent.subject
      assert_equal [studier.student.email], sent.to
      assert_match studier.student.full_name, sent.body
    end
  end

  private
    def with_mail(method, *args)
      Mailer.send(method, *args)
    end
end