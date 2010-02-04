require 'action_view_test'

class YuiHelperTest < ActionView::TestCase
  def test_script
    assert_dom_equal(
      javascript_include_tag("/yui2/foo/bar"),
      yui_javascript("foo/bar")
    )
  end
  
  def test_stylesheet
    assert_dom_equal(
      stylesheet_link_tag("/yui2/foo/bar"),
      yui_stylesheet("foo/bar")
    )
  end
end