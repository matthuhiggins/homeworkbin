require 'test_helper'

class MailerTest < ActionMailer::TestCase
  def test_registration
    registration = Factory :registration
    with_mail :registration, registration do |sent|
      assert_equal 'Confirm your email address', sent.subject
      assert_equal [registration.email], sent.to
      assert_match registration.token, sent.body
    end
  end
  
  def test_invitation
    invitation = Factory :invitation
    with_mail :invitation, invitation do |sent|
      assert_equal "#{invitation.teacher} added you to #{invitation.course.name}", sent.subject
      assert_equal [invitation.email], sent.to
      assert_match invitation.token, sent.body
    end
  end

  def test_lost_password
    lost_password = Factory :lost_password
    with_mail :lost_password, lost_password do |sent|
      assert_equal "Homework Bin password change", sent.subject
      assert_equal [lost_password.person.email], sent.to
      assert_match lost_password.token, sent.body
    end
  end

  private
    def with_mail(method, *args)
      Mailer.send "deliver_#{method}", *args
      yield Mailer.deliveries.first
    end
end