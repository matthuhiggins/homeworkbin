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
      $(function() {
        $('#foo').focus();
      });
      </script>
      }, script
  end
  
  def test_controller_stylesheet_tag
    @controller = Class.new do
      def self.name
        'Acme::BabyKillerController'
      end
    end.new

    assert_equal(
      stylesheet_link_tag('acme/baby_killer'),
      controller_stylesheet_tag
    )
  end
end