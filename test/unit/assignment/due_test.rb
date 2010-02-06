require 'active_record_test'

class Assignment::DueTest < ActiveSupport::TestCase
  include ActiveRecord::DateValidationTests
  test_date_format_validation :due_date
  
  def test_minutes_validation
    assert Factory.build(:assignment, :due_minutes => -1).invalid?
    assert Factory.build(:assignment, :due_minutes => 1441).invalid?
    assert Factory.build(:assignment, :due_minutes => 0).valid?
    assert Factory.build(:assignment, :due_minutes => 1440).valid?
  end
  
  def test_due_at_reader
    assert_equal(
      Factory.build(:assignment, :due_date => '05/22/2004', :due_minutes => 122).due_at,
      Time.zone.local(2004, 5, 22, 2, 2)
    )
  end
  
  def test_due_at_writer
    assignment = Factory.build :assignment, :due_at => Time.utc(2004, 10, 22, 10, 5)
    
    assert_equal Date.new(2004, 10, 22), assignment.due_date
    assert_equal 605, assignment.due_minutes
  end
end