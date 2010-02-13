require 'active_record_test'

class Assignment::DueTest < ActiveRecord::TestCase
  include ActiveRecord::DateValidationTests
  test_date_format_validation :due_date
  
  def test_validate_minutes_inclusion
    assert Factory.build(:assignment, :due_minutes => -1).invalid?
    assert Factory.build(:assignment, :due_minutes => 1441).invalid?
    assert Factory.build(:assignment, :due_minutes => 0).valid?
    assert Factory.build(:assignment, :due_minutes => 1440).valid?
  end

  def test_validate_due_date_within_course
    course = Factory :course

    assert (assignment = Factory.build(:assignment, :due_date => course.start_date - 1)).invalid?
    assert_equal 'is before this course', assignment.errors.on(:due_date)

    assert (assignment = Factory.build(:assignment, :due_date => course.end_date + 1)).invalid?
    assert_equal 'is after this course', assignment.errors.on(:due_date)
    
    assert (assignment = Factory.build(:assignment, :due_date => course.start_date)).valid?
    assert (assignment = Factory.build(:assignment, :due_date => course.end_date)).valid?
  end
  
  def test_due_at_reader
    assert_equal(
      Factory.build(:assignment, :due_date => '05/22/2004', :due_minutes => 122).due_at,
      Time.zone.local(2004, 5, 22, 2, 2)
    )
  end
  
  def test_due_at_sets_time_zone
    with_time_zone 'Kuwait' do
      due_at = Factory.build(:assignment, :due_date => '01/22/2004', :due_minutes => 122).due_at
      assert_equal Time.zone.utc_offset, due_at.utc_offset
      assert_equal 'AST', due_at.zone
      assert_equal 2, due_at.hour
    end
  end
  
  def test_due_at_writer
    assignment = Factory.build :assignment_without_due, :due_at => Time.utc(2004, 10, 22, 10, 5)
    
    assert_equal Date.new(2004, 10, 22), assignment.due_date
    assert_equal 605, assignment.due_minutes
  end
  
  def test_open?
    assert Factory.build(:assignment_without_due, :due_at => Time.current + 65).open?
    assert !Factory.build(:assignment_without_due, :due_at => Time.current - 65).open?
  end

  def test_closed?
    assert !Factory.build(:assignment_without_due, :due_at => Time.current + 65).closed?
    assert Factory.build(:assignment_without_due, :due_at => Time.current - 65).closed?
  end
end