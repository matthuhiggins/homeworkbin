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

  def test_relative_date
    assert_equal 'yesterday', relative_date(Date.current.yesterday)
    assert_equal 'today', relative_date(Date.current)
    assert_equal 'tomorrow', relative_date(Date.current.tomorrow)
    assert_equal 'Thu, Dec 25', relative_date(Date.new(2003, 12, 25))
  end
end