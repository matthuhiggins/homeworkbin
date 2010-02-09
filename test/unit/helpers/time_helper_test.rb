require 'action_view_test'

class TimeHelperTest < ActionView::TestCase
  def test_assignment_due_at
    assignment = Factory.build :assignment

    assert_equal assignment.due_date.strftime('%A, %B %d'), assignment_due_at(assignment)
  end
  
  def test_hour_options
    options = hour_options
    
    assert_equal 48, options.size
    assert options.include?(['11:00am', 660])
    assert options.include?(['2:30pm', 870])
  end
end