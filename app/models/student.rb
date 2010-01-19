class Student < Person
  has_many :learners
  has_many :learning, :through => :learners, :source => :course
end