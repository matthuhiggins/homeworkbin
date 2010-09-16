require 'action_view_test'

class ErrorsHelperTest < ActionView::TestCase
  class TestModel < Struct.new(:errors)
  end
  
  test 'error_message_on' do
    assert_errors_on '', []
    assert_errors_on '<div class="error">is fucked</div>', ['is fucked']
    assert_errors_on '<div class="error">foo</div>', ['foo', 'bar']
    assert_errors_on '<div class="error">what up foo</div>', ['foo'], prepend: 'what up '
    assert_errors_on '<div class="error">foo means nothing</div>', ['foo'], append: ' means nothing'
  end

  private
    def assert_errors_on(expected, errors, options = {})
      assert_dom_equal(
        expected,
        error_message_on(TestModel.new(foo: errors), :foo, options)
      )
    end
end