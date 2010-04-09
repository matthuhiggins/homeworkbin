require 'active_record_test'

class Course::TimeZoneInfoTest < ActiveRecord::TestCase
  def test_time_zone
    course = factory.build
    now_utc = Time.current.utc

    assert_equal course.to_local(now_utc).zone, now_utc.in_time_zone(course.time_zone).zone
  end

  def test_time_zone_info
    course = factory.build

    assert_equal ActiveSupport::TimeZone[course.time_zone], course.time_zone_info
  end

  def test_utc_offset
    course = factory.build

    assert_equal(
      ActiveSupport::TimeZone[course.time_zone].utc_offset,
      course.utc_offset
    )
  end
end