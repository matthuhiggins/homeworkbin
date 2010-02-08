require 'action_view_test'

class TimeHelperTest < ActionView::TestCase
  def test_assignment_due_at
    assert_equal 'Saturday, May 21', assignment_due_at(Factory :assignment, :due_date => Date.new(2005, 5, 21))
  end
  
  def test_hour_options
    options = hour_options
    
    assert_equal 48, options.size
    assert options.include?(['11:00am', 660])
    assert options.include?(['2:30pm', 870])
  end
end