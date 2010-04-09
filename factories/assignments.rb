Factory.define :assignment_without_due, :class => Assignment do |f|
  f.association :course
  f.name        'Make an online posting'
end

Factory.define :assignment, :parent => :assignment_without_due do |f|
  f.due_minutes   720
  f.after_build do |a|
    if a.due_date.blank?
      a.due_date = a.course.start_date + 1
    end
  end
end