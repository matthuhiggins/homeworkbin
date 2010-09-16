require 'active_record_test'

class Course::TimeZoneInfoTest < ActiveRecord::TestCase
  test 'time_zone' do
    course = factory.build
    now_utc = Time.current.utc

    assert_equal course.to_local(now_utc).zone, now_utc.in_time_zone(course.time_zone).zone
  end

  test 'time_zone_info' do
    course = factory.build

    assert_equal ActiveSupport::TimeZone[course.time_zone], course.time_zone_info
  end

  test 'utc_offset' do
    course = factory.build

    assert_equal(
      ActiveSupport::TimeZone[course.time_zone].utc_offset,
      course.utc_offset
    )
  end
end