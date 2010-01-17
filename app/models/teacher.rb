class Teacher < Person
  before_create do |teacher|
    teacher.courses_in_stock = 1
  end
end