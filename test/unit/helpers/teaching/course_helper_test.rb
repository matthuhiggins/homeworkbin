require 'action_view_test'

class Teaching::CourseHelperTest < ActionView::TestCase
  def test_date_uses_existing_values
    course = Factory.build :course, :start_date => '05/22/2004', :end_date => '07/24/2004'

    assert_equal '05/22/2004', course_start_date(course)
    assert_equal '07/24/2004', course_end_date(course)
  end
  
  def test_date_defaults_without_previous
    course = Factory.build :course, :start_date => nil, :end_date => nil

    assert_equal Date.current.strftime('%m/%d/%Y'), course_start_date(course)
    assert_equal (Date.current + 90).strftime('%m/%d/%Y'), course_end_date(course)
  end
  
  def test_date_defaults_to_previous
    teacher = Factory :teacher
    Factory :course, :start_date => '05/22/2004', :end_date => '07/24/2004', :teacher => teacher
    
    course = teacher.teaching.new

    assert_equal '05/22/2004', course_start_date(course)
    assert_equal '07/24/2004', course_end_date(course)
  end
  
  # private
    def assert_previous_used(attribute)
      
    end
end