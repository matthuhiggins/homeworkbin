class Teacher < Person
  has_many :courses
  
  before_create do |teacher|
    teacher.courses_available = 1
  end
end