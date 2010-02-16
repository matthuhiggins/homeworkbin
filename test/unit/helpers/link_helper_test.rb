require 'action_view_test'

class LinkHelperTest < ActionView::TestCase
  def test_cancel
    
  end
  
  def test_logout
    assert_dom_equal(
      link_to('Logout', logout_path, :method => :delete),
      logout
    )
  end
end