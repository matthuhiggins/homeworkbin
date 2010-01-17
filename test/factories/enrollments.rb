Factory.define :enrollment do |f|
  f.association :course
  f.email       'brame@washington.edu'
end