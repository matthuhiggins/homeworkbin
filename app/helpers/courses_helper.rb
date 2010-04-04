module CoursesHelper
  def course_form(course, &block)
    if course.new_record?
      options = {:url => teachings_path, :html => {:id => 'course-form'}}
    else
      options = {:url => teaching_path(course), :html => {:method => :put, :id => 'course-form'}}
    end

    form_for course, options, &block
  end

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
    course.new_record? ? 'Create course' : 'Save changes'
  end
  
  def course_date_range(course)
    "#{course.start_date.strftime '%b %d'} - #{course.end_date.strftime '%b %d'}"
  end
  
  def distance_of_course_in_words(course, date = Date.current)
    if date < course.start_date
      "Starts in #{time_ago_in_words course.start_date}"
    elsif date == course.start_date
      'Starts today'
    elsif date > course.start_date && date < course.end_date
      "Ends in #{time_ago_in_words course.end_date}"
    elsif date == course.end_date
      'Ends today'
    elsif date > course.end_date
      "Ended #{time_ago_in_words course.end_date} ago"
    end
  end
end