module AssignmentsHelper
  def default_assignment_due_date(assignment)
    if assignment.due_date.present?
      assignment.due_date.strftime '%m/%d/%Y'
    else
      Date.current.strftime '%m/%d/%Y'
    end
  end
  
  def assignment_due_minute_options
    options = []

    (0..23).each do |hour|
      meridian = hour < 12 ? 'am' : 'pm'
      display_hour = hour % 12
      display_hour = 12 if display_hour == 0
      [0, 30].each do |minutes|
        options << ["#{display_hour}:#{minutes.to_s.rjust 2, '0'}#{meridian}", hour * 60 + minutes]
      end
    end

    options
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
  
  def save_assignment_text(assignment)
    assignment.new_record? ? 'Assign homework' : 'Update assignment'
  end
  
  def assignment_due_at(assignment)
    assignment.due_at.strftime '%a, %b %d'
  end
end