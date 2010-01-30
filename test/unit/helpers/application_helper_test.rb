require 'action_view_test'

class ApplicationHelperTest < ActionView::TestCase
  def test_title
    title "hello world"
    assert_equal " - hello world", @content_for_title
  end
end