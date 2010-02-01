require 'action_view_test'

class ApplicationHelperTest < ActionView::TestCase
  def test_title
    title "hello world"
    assert_equal " - hello world", @content_for_title
  end
  
  def test_focus
    script = focus 'foo'
    assert_dom_equal "<script>document.getElementById('foo').focus();", script
  end
end