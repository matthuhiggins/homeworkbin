require 'action_view_test'

class LinkHelperTest < ActionView::TestCase
  def test_cancel_with_referral
    controller.request.env['HTTP_REFERER'] = 'foo'

    assert_dom_equal(
      link_to('Cancel', 'javascript:history.back()', :class => 'cancel'),
      cancel
    )
  end
  
  def test_activation_cancel_link_without_referral
    controller.request.env['HTTP_REFERER'] = nil
    assert_equal '', cancel
  end
  
  def test_logout
    assert_dom_equal(
      link_to('Logout', logout_path, :method => :delete),
      logout
    )
  end

  def test_topic_tag
    controller.class_eval { def topic; 'foo'; end }

    assert_dom_equal(
      "<span class='current topic'>hello world</span>",
      topic_tag(:span, 'foo') { 'hello world' }
    )

    assert_dom_equal(
      "<span class='topic'>hello world</span>",
      topic_tag(:span, 'bar') { 'hello world' }
    )
  end
end