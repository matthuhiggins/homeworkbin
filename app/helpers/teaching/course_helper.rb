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
    elsif current_teacher.teaching.previous.present?
      current_teacher.teaching.previous.send attribute
    else
      Date.current + (attribute == :end_date ? 90 : 0)
    end
  end
end