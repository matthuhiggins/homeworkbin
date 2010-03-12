require 'action_view_test'

class ApplicationHelperTest < ActionView::TestCase
  def test_title
    title "hello world"
    assert_equal " - hello world", @content_for_title
  end
  
  def test_body
    assert_dom_equal(
      '<body class="yui-skin-sam" id="test-index">hello world</body>',
      body { 'hello world' }
    )
  end
  
  def test_focus
    script = focus 'foo'

    assert_dom_equal %{
      <script>
      YAHOO.util.Event.onDOMReady(function() {
        document.getElementById('foo').focus();
      });
      </script>
      }, script
  end
end