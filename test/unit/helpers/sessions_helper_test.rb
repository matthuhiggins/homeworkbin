require 'action_view_test'

class SessionsHelperTest < ActionView::TestCase
  test 'login_value_with_cookies' do
    cookies[:last_login] = 'foo'
    assert_equal 'foo', email_login_value
  end

  test 'login_value_with_params' do
    cookies[:last_login] = 'foo'
    params[:email] = 'bar'
    assert_equal 'bar', email_login_value
  end
  
  test 'link_to_logout' do
    assert_dom_equal(
      link_to('Logout', logout_path, method: :delete),
      link_to_logout
    )
  end
end