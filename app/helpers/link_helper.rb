module LinkHelper
  def cancel
    if controller.request.referer.present?
      link_to 'Cancel', 'javascript:history.back()', :class => 'cancel'
    else
      ''
    end
  end
  
  def topic_tag(tag, topic, &block)
    css_class = controller.topic == topic ? 'current topic' : 'topic'
    content_tag(tag, :class => css_class, &block)
  end
end