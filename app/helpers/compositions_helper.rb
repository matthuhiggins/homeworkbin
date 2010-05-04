module CompositionsHelper
  include TimeHelper

  def composition_handed_in_at(composition)
    date = relative_date composition.handed_in_at.to_date
    
    date + ' at ' + hour(composition.handed_in_at)
  end
  
  HTML_REGEX = /<\/?[^>]*>/
  def composition_preview(composition, length)
    composition.original.gsub('<br>', ' ').gsub(HTML_REGEX, '')[0, length]
  end
end