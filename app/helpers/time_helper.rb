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
end