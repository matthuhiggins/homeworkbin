Factory.define :learner do |f|
  f.association :course
  f.student     { Factory :person }
end