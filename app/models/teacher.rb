class Teacher < Person
  has_many :courses
  
  before_create do |teacher|
    teacher.courses_in_stock = 1
  end
end