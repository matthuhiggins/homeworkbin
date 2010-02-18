require 'action_view_test'

class Teaching::RegistrationHelperTest < ActionView::TestCase
  def test_check_your_email
    assert_equal 'Check your email', check_your_email('a@b.com')
    assert_equal '<a href="http://gmail.com">Check your email</a>', check_your_email('matt@gmail.com')
    assert_equal '<a href="http://mail.yahoo.com">Check your email</a>', check_your_email('matt@yahoo.com')
  end
end