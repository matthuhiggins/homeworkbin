class Course
  module TimeZoneInfo
    extend ActiveSupport::Concern

    included do
      delegate :utc_offset, :to => :time_zone_info
      
      before_create :unless => :time_zone
        self.time_zone = 'Pacific Time (US & Canada)'
      end
    end

    def to_local(utc_time)
      utc_time.in_time_zone(time_zone)
    end
    
    def time_zone
      self[:time_zone] ||= 'Pacific Time (US & Canada)'
    end

    def time_zone_info
      ActiveSupport::TimeZone[time_zone]
    end
  end
end
