module TimeHelper
  def assignment_due_at(assignment)
    assignment.due_date.strftime '%A, %B %d'
  end
end