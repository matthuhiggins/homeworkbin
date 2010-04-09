Factory.define :person do |f|
  f.full_name           'Matty Higgins'
  f.sequence(:email)    { |n| "student#{n}@alaska.edu" }
  f.password            'sekret'
end

Factory.define :teacher, :class => Teacher, :parent => :person do |f|
end

Factory.define :student, :class => Student, :parent => :person do |f|
end