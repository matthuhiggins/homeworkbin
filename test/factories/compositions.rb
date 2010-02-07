Factory.define :composition do |f|
  f.association :assignment
  f.association :studier
  f.text        'The quick brown fox jumped over the lazy dog'
end