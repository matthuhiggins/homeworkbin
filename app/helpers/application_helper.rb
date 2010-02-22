module ApplicationHelper
  def title(title)
    content_for(:title) { ' - ' + title }
  end
  
  def focus(dom_id)
    content_tag :script, <<-eval
      YAHOO.util.Event.onDOMReady(function() {
        document.getElementById('#{dom_id}').focus();
      });
    eval
  end
end
