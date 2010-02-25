module Teaching::AssignmentHelper
  def assignment_form(assignment, &block)
    if assignment.new_record?
      options = {
        :url => teaching_assignments_path(current_course),
        :html => {:id => 'assignment-form'}
      }
    else
      options = {
        :url => teaching_assignment_path(current_course, assignment),
        :html => {:method => :put, :id => 'assignment-form'}
      }
    end

    form_for assignment, options, &block
  end
  
  def default_assignment_due_date(assignment)
    if assignment.due_date.present?
      assignment.due_date.strftime '%m/%d/%Y'
    else
      Date.current.strftime '%m/%d/%Y'
    end
  end
  
  def default_assignment_due_minutes(assignment)
    if assignment.due_minutes.present?
      assignment.due_minutes
    elsif assignment.last.present?
      assignment.last.due_minutes
    else
      12 * 60
    end
  end
  
  def default_assignment_handout(assignment)
    if assignment.handout.present?
      assignment.handout == '1'
    else
      true
    end
  end
  
  def assignment_due_at(assignment)
    assignment.due_at.strftime '%a, %b %d'
    # strftime('%I:%M %p').downcase.gsub(/^0/, '')
  end
  
  def relative_assignment_due_date(due_date)
    if due_date.today?
      'Today'
    elsif due_date == Date.current.tomorrow
      'Tomorrow'
    else
      due_date.strftime('%a, %b %d')
    end
  end
  
  def next_assignment(assignments)
    if assignment = assignments.next
      yield(assignment)
    end
  end
end