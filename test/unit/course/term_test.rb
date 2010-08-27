require 'active_record_test'

class Course::TermTest < ActiveRecord::TestCase
  def test_date_range
    course = factory.create start_date: '12/25/2004', end_date: '2/20/2005'
    
    assert_equal Date.new(2004, 12, 25)..Date.new(2005, 2, 20), course.date_range
  end
end