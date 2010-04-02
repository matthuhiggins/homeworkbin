module YuiHelper
  def yui_javascript(*sources)
    sources.map { |source| javascript_include_tag("/yui2/#{source}") }.join("\n").html_safe
  end
  
  def yui_stylesheet(*sources)
    sources.map { |source| stylesheet_link_tag("/yui2/#{source}") }.join("\n").html_safe
  end
end