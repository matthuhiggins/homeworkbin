require 'active_record_test'

class Assignment::DueTest < ActiveSupport::TestCase
  include ActiveRecord::DateValidationTests
  test_date_format_validation :due_date
  
  def test_minutes_range
    
  end
end