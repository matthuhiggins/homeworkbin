require 'action_view_test'

class SessionsHelperTest < ActionView::TestCase
  def test_login_value_with_cookies
    cookies[:last_email] = 'foo'
    assert_equal 'foo', email_login_value
  end

  def test_login_value_with_params
    cookies[:last_email] = 'foo'
    params[:email] = 'bar'
    assert_equal 'bar', email_login_value
  end
  
  def test_logout
    assert_dom_equal(
      link_to('Logout', logout_path, :method => :delete),
      logout
    )
  end
end