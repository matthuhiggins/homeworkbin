Factory.define :assignment do |f|
  f.association :course
  f.name        'Make an online posting'
  f.after_build do |a|
    if a.due_date.blank?
      a.due_date = a.course.start_date + 1
    end
    if a.due_minutes.blank?
      a.due_minutes = 720
    end
  end
end