module TimeHelper
  include ErrorsHelper

  def date_format_div(record, method)
    if record.errors[method].present?
      error_message_on record, method
    else
      content_tag :div, 'mm/dd/yyyy', :class => 'tip'
    end
  end
  
  def hour(time)
    time.strftime('%I:%M%p').tap do |format|
      format.downcase!
      format.gsub!(/^0/, '')
    end
  end
  
  def month(time)
    
  end
end