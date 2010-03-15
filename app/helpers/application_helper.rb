module ApplicationHelper
  def title(title)
    content_for(:title) { ' - ' + title }
  end
  
  def body(&block)
    html_options = {:class => 'yui-skin-sam', :id => "#{controller_name}-#{action_name}"}
    content_tag(:body, html_options, &block)
  end
  
  def focus(dom_id)
    content_tag :script, <<-eval
      $(function() {
        $('##{dom_id}').focus();
      });
    eval
  end
end
