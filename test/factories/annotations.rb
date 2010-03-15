Factory.define :annotation do |f|
  f.association :submission
  f.comment     'Amazing work!'
  f.snippet     'Despite these facts, the consequences are not causal'
end