Factory.define :course do |f|
  f.name        'Environmental Science 110'
  f.description 'Easiest class in the world'
  f.start       Date.new(2004, 1, 1)
  f.end         Date.new(2004, 3, 17)
  f.teacher     { Factory :person}
end