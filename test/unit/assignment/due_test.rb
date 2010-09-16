require 'active_record_test'

class Assignment::DueTest < ActiveRecord::TestCase
  include ActiveRecord::DateValidationTests
  tests_date_format_validation :due_date

  test 'finders' do
    course = Factory.course.create start_date: 1.month.ago.to_date, end_date: 1.month.from_now.to_date
    due_last_week = factory.create course: course, due_date: 2.days.ago.to_date
    due_yesterday = factory.create course: course, due_date: 1.day.ago.to_date
    due_today = factory.create course: course, due_date: Date.current
    due_tomorrow = factory.create course: course, due_date: 1.day.from_now.to_date
    due_next_week = factory.create course: course, due_date: 1.week.from_now.to_date

    assert_equal [due_yesterday, due_last_week], course.assignments.past
    assert_equal due_yesterday, course.assignments.previous
    assert_equal [due_today, due_tomorrow, due_next_week], course.assignments.upcoming
    assert_equal due_today, course.assignments.next
  end

  test 'validate minutes inclusion' do
    assert factory.build(due_minutes: -1).invalid?
    assert factory.build(due_minutes: 1441).invalid?
    assert factory.build(due_minutes: 0).valid?
    assert factory.build(due_minutes: 1440).valid?
  end

  test 'validate due_date within term' do
    course = Factory.course.create

    assert (assignment = factory.build(due_date: course.start_date - 1)).invalid?
    assert_equal ['is before this course'], assignment.errors[:due_date]

    assert (assignment = factory.build(due_date: course.end_date + 1)).invalid?
    assert_equal ['is after this course'], assignment.errors[:due_date]
    
    assert (assignment = factory.build(due_date: course.start_date)).valid?
    assert (assignment = factory.build(due_date: course.end_date)).valid?
  end
  
  test 'due_at reader' do
    assert_equal(
      factory.build(due_date: '05/22/2004', due_minutes: 122).due_at,
      Time.zone.local(2004, 5, 22, 2, 2)
    )
  end
  
  test 'due_at sets time zone' do
    with_time_zone 'Kuwait' do
      due_at = factory.build(due_date: '01/22/2004', due_minutes: 122).due_at
      assert_equal Time.zone.utc_offset, due_at.utc_offset
      assert_equal 'AST', due_at.zone
      assert_equal 2, due_at.hour
    end
  end
  
  test 'due_at writer' do
    assignment = factory.build due_at: Time.utc(2004, 10, 22, 10, 5)
    
    assert_equal Date.new(2004, 10, 22), assignment.due_date
    assert_equal 605, assignment.due_minutes
  end
  
  test 'past?' do
    assert !factory.build(due_date: Date.current).past?
    assert factory.build(due_date: Date.current - 1).past?
  end
  
  test 'today?' do
    assert factory.build(due_date: Date.current).today?
    assert !factory.build(due_date: Date.current - 1).today?
    assert !factory.build(due_date: Date.current - 1).today?
  end
  
  test 'future?' do
    assert !factory.build(due_date: Date.current).future?
    assert factory.build(due_date: Date.current + 1).future?
  end
  
  test 'late_submission?' do
    course = Factory.course.create start_date: Date.new(2005, 4, 10), end_date: Date.new(2005, 6, 10)
    assignment = factory.create course: course, due_date: Date.new(2005, 5, 10), due_minutes: 180

    assert !assignment.late_submission?(Factory.submission.build(assignment: assignment, handed_in_at: Time.zone.local(2005, 5, 10, 2)))
    assert assignment.late_submission?(Factory.submission.build(assignment: assignment, handed_in_at: Time.zone.local(2005, 5, 10, 4)))
  end
end