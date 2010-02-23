class Person
  module TimeZone
    def self.included(base)
      base.class_eval do
        before_create(:unless => :time_zone) do |person|
          person.time_zone = 'Pacific Time (US & Canada)'
        end
        delegate :utc_offset, :to => :time_zone_info
      end
    end

    def to_local(utc_time)
      utc_time.in_time_zone(time_zone)
    end

    def time_zone_info
      ActiveSupport::TimeZone[time_zone]
    end
  end
end