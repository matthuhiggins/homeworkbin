Factory.define :composition do |f|
  f.association :assignment
  f.association :studier
  f.original    'The quick brown fox jumped over the lazy dog'
end

Factory.define :submission, :class => Composition, :parent => :composition do |s|
  s.hand_in     true
end
  