require 'action_view_test'

class ApplicationHelperTest < ActionView::TestCase
  def test_title
    @_content_for = Hash.new { |h,k| h[k] = ActiveSupport::SafeBuffer.new }
    title 'hello world'
    assert_equal " - hello world", @_content_for[:title]
  end
  
  def test_body
    assert_dom_equal(
      '<body class="yui-skin-sam" id="test-index">hello world</body>',
      body { 'hello world' }
    )
  end
  
  def test_focus
    script = focus 'foo'
    expected = %{
      <script>
      $(function() {
        $('#foo').focus();
      });
      </script>
    }

    assert_dom_equal expected.squish, script.squish!
  end
  
  module Foo
    class BarController < ActionView::TestCase::TestController
      def self.name; 'Foo::BarController'; end
    end
  end

  def test_controller_stylesheet_tag
    @controller = Foo::BarController.new

    assert_equal(
      stylesheet_link_tag('foo/bar'),
      controller_stylesheet_tag
    )
  end
end