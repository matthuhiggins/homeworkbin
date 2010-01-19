class Student < Person
  has_many :learners
  has_many :courses, :through => :learners
end