require 'action_view_test'

class LinkHelperTest < ActionView::TestCase
  test 'cancel_with_referral' do
    controller.request.env['HTTP_REFERER'] = 'foo'

    assert_dom_equal(
      link_to('Cancel', 'javascript:history.back()', class: 'cancel'),
      cancel
    )
  end
  
  test 'cancel_link_without_referral' do
    controller.request.env['HTTP_REFERER'] = nil
    assert_equal '', cancel
  end
  
  test 'topic_tag' do
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