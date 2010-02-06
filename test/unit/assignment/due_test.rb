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
  
  def test_due_at
    assert_equal(
      Factory.build(:assignment, :due_date => '05/22/2004', :due_minutes => 122).due_at,
      Time.mktime(2004, 5, 22, 2, 2)
    )
  end
end