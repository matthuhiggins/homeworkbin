module ApplicationHelper
  def title(title)
    content_for(:title) { ' - ' + title }
  end
  
  def focus(dom_id)
    content_tag :script, "document.getElementById('#{dom_id}').focus();"
  end
end
