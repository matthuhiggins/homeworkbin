Factory.sequence :annotation_identifier do |n|
  n
end

Factory.define :annotation do |f|
  f.association :submission
  f.identifier  { Factory.next :annotation_identifier }
  f.comment     'Amazing work!'
  f.snippet     'Despite these facts, the consequences are not causal'
end