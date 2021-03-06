module ApplicationHelper
  def title(title)
    content_for(:title) { ' - ' + title }
  end

  def javascripts(*srcs)
    content_for(:javascripts) { javascript_include_tag *srcs }    
  end
  
  def body(&block)
    html_options = {class: 'yui-skin-sam', id: "#{controller_name}-#{action_name}"}
    content_tag(:body, html_options, &block)
  end
  
  def focus(dom_id)
    content_tag :script, <<-eval
      $(function() {
        $('##{dom_id}').focus();
      });
    eval
  end
  
  def controller_stylesheet
    controller.class.name.gsub(/Controller/, '').underscore
  end

  def if_present(object, &block)
    capture(object, &block) if object.present?
  end
end
