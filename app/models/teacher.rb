class Teacher < Person
  has_many :teaching, :class_name => 'Course'
  
  before_create do |teacher|
    teacher.courses_available = 1
  end
end