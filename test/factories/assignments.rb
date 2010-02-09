Factory.define :assignment_without_due, :class => Assignment do |f|
  f.association :course
  f.name        'Make an online posting'
end

Factory.define :assignment, :parent => :assignment_without_due do |f|
  f.due_date      Date.new(2004, 2, 15) 
  f.due_minutes   720
end