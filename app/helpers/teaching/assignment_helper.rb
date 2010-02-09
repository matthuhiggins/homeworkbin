module Teaching::AssignmentHelper
  def assignment_due_minutes(assignment)
    if assignment.due_minutes.present?
      assignment.due_minutes
    elsif assignment.last.present?
      assignment.last.due_minutes
    else
      0
    end
  end
end