require 'action_view_test'

class TimeHelperTest < ActionView::TestCase
  def test_hour_options
    options = hour_options
    
    assert_equal 48, options.size
    assert options.include?(['11:00am', 660])
    assert options.include?(['2:30pm', 870])
  end

  def test_date_format_div
    
  end
end