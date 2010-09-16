require 'action_view_test'

class RegistrationsHelperTest < ActionView::TestCase
  test 'check_your_email' do
    assert_equal 'Check a@b.com', check_your_email('a@b.com')
    assert_equal '<a href="http://gmail.com">Check matt@gmail.com</a>', check_your_email('matt@gmail.com')
    assert_equal '<a href="http://mail.yahoo.com">Check matt@yahoo.com</a>', check_your_email('matt@yahoo.com')
  end
end