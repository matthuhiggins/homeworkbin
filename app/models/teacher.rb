class Teacher < Person
  has_many :teaching, :class_name => 'Course'
  
  before_create do |teacher|
    teacher.courses_available = 1
    teacher.started_as_teacher = true
  end
end