Factory.define :course do |f|
  f.name          'Environmental Science 110'
  f.start_date    Date.new(2004, 1, 1)
  f.end_date      Date.new(2004, 3, 17)
  f.association   :teacher
end