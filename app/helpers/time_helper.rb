module TimeHelper
  def hour_options
    options = []

    (0..23).each do |hour|
      meridian = hour < 12 ? 'am' : 'pm'
      display_hour = hour % 12
      display_hour = 12 if display_hour == 0
      [0, 30].each do |minutes|
        options << ["#{display_hour}:#{minutes.to_s.rjust 2, '0'}#{meridian}", hour * 60 + minutes]
      end
    end

    options
  end
  
  def date_format_div(record, method)
    if record.errors.on(method).present?
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
end