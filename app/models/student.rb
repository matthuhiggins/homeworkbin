class Student < Person
  has_many :learners
  has_many :studying, :through => :learners, :source => :course
end