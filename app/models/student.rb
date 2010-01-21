class Student < Person
  has_many :studiers
  has_many :studying, :through => :studiers, :source => :course
end