class Student < Person
  has_many :studiers
  has_many :studying, through: :studiers, source: :course
  has_many :enrollments, foreign_key: 'email', primary_key: 'email'
end