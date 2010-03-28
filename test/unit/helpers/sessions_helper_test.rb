require 'action_view_test'

class SessionsHelperTest < ActionView::TestCase
  def test_login_value_with_cookies
    cookies[:last_login] = 'foo'
    assert_equal 'foo', email_login_value
  end

  def test_login_value_with_params
    cookies[:last_login] = 'foo'
    params[:email] = 'bar'
    assert_equal 'bar', email_login_value
  end
  
  def test_link_to_logout
    assert_dom_equal(
      link_to('Logout', logout_path, :method => :delete),
      link_to_logout
    )
  end
end