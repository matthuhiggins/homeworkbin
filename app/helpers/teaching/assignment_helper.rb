module Teaching::AssignmentHelper
  def assignment_due_minutes(assignment)
    if assignment.due_minutes.present?
      assignment.due_minutes
    elsif current_course.assignments.previous.present?
      current_course.assignments.previous.due_minutes
    else
      0
    end
  end
end