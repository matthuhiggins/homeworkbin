Factory.define :annotations do |f|
  f.association :composition
  f.comment     'Amazing work!'
  f.snippet     'Despite these facts, the consequences are not causal'
end