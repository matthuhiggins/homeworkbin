require 'active_record_test'

class Course::TermTest < ActiveRecord::TestCase
  def test_finders
    teacher = Factory.teacher.create
    past_course = factory.create teacher: teacher, start_date: 3.months.ago.to_date, end_date: 1.month.ago.to_date
    ends_today = factory.create teacher: teacher, start_date: 2.months.ago.to_date, end_date: Date.current
    current_course = factory.create teacher: teacher, start_date: 1.month.ago.to_date, end_date: 1.month.from_now.to_date
    starts_today = factory.create teacher: teacher, start_date: Date.current, end_date: 2.months.from_now.to_date
    upcoming_course = factory.create teacher: teacher, start_date: 1.month.from_now.to_date, end_date: 3.months.from_now.to_date

    assert_equal [past_course], Course.past
    assert_equal [ends_today, current_course, starts_today], Course.current
    assert_equal [upcoming_course], Course.upcoming
  end

  def test_date_range
    course = factory.create start_date: '12/25/2004', end_date: '2/20/2005'
    
    assert_equal Date.new(2004, 12, 25)..Date.new(2005, 2, 20), course.date_range
    assert !course.date_range.exclude_end?
  end

  def test_current?
    assert !factory.build(start_date: 3.months.ago.to_date, end_date: 1.month.ago.to_date).current?
    assert factory.build(start_date: 1.month.ago.to_date, end_date: 2.months.from_now.to_date).current?
    assert !factory.build(start_date: 1.month.from_now.to_date, end_date: 3.months.from_now.to_date).current?
  end
end