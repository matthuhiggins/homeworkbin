class Student < Person
  has_many :studiers
  has_many :courses, through: :studiers
  has_many :enrollments, foreign_key: 'email', primary_key: 'email'
end