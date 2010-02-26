require 'action_view_test'

class TimeHelperTest < ActionView::TestCase
  def test_hour_options
    options = hour_options
    
    assert_equal 48, options.size
    assert options.include?(['11:00am', 660])
    assert options.include?(['2:30pm', 870])
  end

  def test_date_format_div_shows_error
    course = Factory.build :course, :start_date => 'xx/yy/lolz'
    assert course.invalid?
    assert_dom_equal "<div class='formError'>must be mm/dd/yyyy</div>", date_format_div(course, :start_date)
  end
  
  def test_date_format_div_shows_tip
    course = Factory.build :course
    assert course.valid?
    assert_dom_equal "<div class='tip'>mm/dd/yyyy</div>", date_format_div(course, :start_date)
  end
  
  def test_hour
    assert_equal '1:05am', hour(Time.utc(2005, 5, 25, 1, 5))
  end
end