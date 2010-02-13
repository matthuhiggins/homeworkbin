module Teaching::CourseHelper
  def course_start_date(course)
    course_date(course, :start_date).strftime '%m/%d/%Y'
  end
  
  def course_end_date(course)
    course_date(course, :end_date).strftime '%m/%d/%Y'
  end
  
  def course_date(course, attribute)
    if course.send(attribute).present?
      course.send attribute
    elsif course.last.present?
      course.last.send attribute
    else
      Date.current + (attribute == :end_date ? 90 : 0)
    end
  end
  
  def save_course_text(course)
    course.new_record? ? 'Create course »' : 'Save changes'
  end
  
  def course_form(course, &block)
    if course.new_record?
      options = {:url => teachings_path, :html => {:id => 'course-form'}}
    else
      options = {:url => teaching_path(course), :html => {:method => :put, :id => 'course-form'}}
    end

    form_for course, options, &block
  end
  
  def course_date_range(course)
    "#{course.start_date.strftime '%b %d'} - #{course.end_date.strftime '%b %d'}"
  end
end