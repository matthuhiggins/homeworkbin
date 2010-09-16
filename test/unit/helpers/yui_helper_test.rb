require 'action_view_test'

class YuiHelperTest < ActionView::TestCase
  test 'script' do
    assert_dom_equal(
      javascript_include_tag("/yui2/foo/bar"),
      yui_javascript("foo/bar")
    )
  end
  
  test 'stylesheet' do
    assert_dom_equal(
      stylesheet_link_tag("/yui2/foo/bar"),
      yui_stylesheet("foo/bar")
    )
  end
end