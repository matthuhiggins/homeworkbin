Factory.define :composition do |f|
  f.association :assignment
  f.association :learner
  f.paper       "The quick brown fox jumped over the lazy dog"
end