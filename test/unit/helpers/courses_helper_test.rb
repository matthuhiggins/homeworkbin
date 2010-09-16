require 'action_view_test'

class CoursesHelperTest < ActionView::TestCase
  test 'date_uses_existing_values' do
    course = Factory.course.build start_date: '05/22/2004', end_date: '07/24/2004'

    assert_equal '05/22/2004', course_start_date(course)
    assert_equal '07/24/2004', course_end_date(course)
  end
  
  test 'date_defaults_without_last' do
    course = Factory.course.build start_date: nil, end_date: nil

    assert_equal Date.current.strftime('%m/%d/%Y'), course_start_date(course)
    assert_equal (Date.current + 90).strftime('%m/%d/%Y'), course_end_date(course)
  end
  
  test 'date_defaults_to_last' do
    teacher = Factory.teacher.create
    Factory.course.create start_date: '05/22/2004', end_date: '07/24/2004', teacher: teacher

    course = teacher.courses.new

    assert_equal '05/22/2004', course_start_date(course)
    assert_equal '07/24/2004', course_end_date(course)
  end

  test 'save_course_text' do
    assert_equal 'Create course', save_course_text(Factory.course.build)
    assert_equal 'Save changes', save_course_text(Factory.course.create)
  end
  
  test 'course_form_options' do
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