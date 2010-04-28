module TimeHelper
  include ErrorsHelper

  def date_format_div(record, method)
    if record.errors[method].present?
      error_message_on record, method
    else
      content_tag :div, 'mm/dd/yyyy', class: 'tip'
    end
  end
  
  def hour(time)
    time.strftime('%I:%M%p').tap do |format|
      format.downcase!
      format.gsub!(/^0/, '')
    end
  end

  def relative_date(date)
    if date == Date.current.yesterday
      'yesterday'
    elsif date.today?
      'today'
    elsif date == Date.current.tomorrow
      'tomorrow'
    else
      date.strftime('%a, %b %d')
    end
  end  
  
  def month(time)
    
  end
end