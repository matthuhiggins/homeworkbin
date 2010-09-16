require 'action_view_test'

class TimeHelperTest < ActionView::TestCase
  test 'date_format_div_shows_error' do
    course = Factory.course.build start_date: 'xx/yy/lolz'
    assert course.invalid?
    assert_dom_equal "<div class='error'>must be mm/dd/yyyy</div>", date_format_div(course, :start_date)
  end
  
  test 'date_format_div_shows_tip' do
    course = Factory.course.build
    assert course.valid?
    assert_dom_equal "<div class='tip'>mm/dd/yyyy</div>", date_format_div(course, :start_date)
  end
  
  test 'hour' do
    assert_equal '1:05am', hour(Time.utc(2005, 5, 25, 1, 5))
  end

  test 'relative_date' do
    assert_equal 'yesterday', relative_date(Date.current.yesterday)
    assert_equal 'today', relative_date(Date.current)
    assert_equal 'tomorrow', relative_date(Date.current.tomorrow)
    assert_equal 'Thu, Dec 25', relative_date(Date.new(2003, 12, 25))
  end
end