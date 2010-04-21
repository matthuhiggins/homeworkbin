require 'action_view_test'

class TimeHelperTest < ActionView::TestCase
  def test_date_format_div_shows_error
    course = Factory.course.build start_date: 'xx/yy/lolz'
    assert course.invalid?
    assert_dom_equal "<div class='error'>must be mm/dd/yyyy</div>", date_format_div(course, :start_date)
  end
  
  def test_date_format_div_shows_tip
    course = Factory.course.build
    assert course.valid?
    assert_dom_equal "<div class='tip'>mm/dd/yyyy</div>", date_format_div(course, :start_date)
  end
  
  def test_hour
    assert_equal '1:05am', hour(Time.utc(2005, 5, 25, 1, 5))
  end
end