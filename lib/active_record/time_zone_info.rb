module ActiveRecord
  module TimeZoneInfo
    def self.included(model)
      model.delegate :utc_offset, :to => :time_zone_info
    end

    def to_local(utc_time)
      utc_time.in_time_zone(time_zone)
    end

    def time_zone_info
      ActiveSupport::TimeZone[time_zone]
    end
  end
end