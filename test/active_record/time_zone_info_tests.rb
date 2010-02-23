module ActiveRecord
  module TimeZoneInfoTests
    def test_time_zone
      person = Factory.build self.class.factory_name
      now_utc = Time.current.utc

      assert_equal person.to_local(now_utc).zone, now_utc.in_time_zone(person.time_zone).zone
    end

    def test_time_zone_info
      person = Factory.build self.class.factory_name

      assert_equal ActiveSupport::TimeZone[person.time_zone], person.time_zone_info
    end

    def test_utc_offset
      person = Factory.build self.class.factory_name

      assert_equal(
        ActiveSupport::TimeZone[person.time_zone].utc_offset,
        person.utc_offset
      )
    end
  end
end