require 'action_view_test'

class TimeHelperTest < ActionView::TestCase
  def test_assignment_due_at
    assert_equal 'Saturday, May 21', assignment_due_at(Factory :assignment, :due_date => '2005/05/21')
  end
end