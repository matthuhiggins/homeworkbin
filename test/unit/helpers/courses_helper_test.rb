require 'action_view_test'

class CoursesHelperTest < ActionView::TestCase
  def test_date_uses_existing_values
    course = Factory.course.build start_date: '05/22/2004', end_date: '07/24/2004'

    assert_equal '05/22/2004', course_start_date(course)
    assert_equal '07/24/2004', course_end_date(course)
  end
  
  def test_date_defaults_without_last
    course = Factory.course.build start_date: nil, end_date: nil

    assert_equal Date.current.strftime('%m/%d/%Y'), course_start_date(course)
    assert_equal (Date.current + 90).strftime('%m/%d/%Y'), course_end_date(course)
  end
  
  def test_date_defaults_to_last
    teacher = Factory.teacher.create
    Factory.course.create start_date: '05/22/2004', end_date: '07/24/2004', teacher: teacher

    course = teacher.teaching.new

    assert_equal '05/22/2004', course_start_date(course)
    assert_equal '07/24/2004', course_end_date(course)
  end

  def test_save_course_text
    assert_equal 'Create course', save_course_text(Factory.course.build)
    assert_equal 'Save changes', save_course_text(Factory.course.create)
  end
  
  def test_course_form_options
    new_course = Factory.course.build
    edit_course = Factory.course.create

    assert_equal(
      {url: teachings_path, html: {id: 'course-form'}},
      course_form_options(new_course)
    )
    assert_equal(
      {url: teaching_path(edit_course), html: {method: :put, id: 'course-form'}},
      course_form_options(edit_course)
    )
  end

  # private
    def assert_previous_used(attribute)
      
    end
end