Factory.define :learner do |f|
  f.association :course
  f.association :student
end