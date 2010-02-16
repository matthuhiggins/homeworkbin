class Classroom
  attr_accessor :teacher, :course, :students

  def initialize
    self.teacher = Factory :teacher, :email => 'bob@wa.edu'
    self.course = Factory :course, :teacher => teacher
    self.students = enroll_students
  end
  
  FULL_NAMES = [
    'Adam Baum',
    'Adam Zapel',
    'Al Bino',
    'Al Dente',
    'Al Fresco',
    'Al K. Seltzer',
    'Alf A. Romeo',
    'Ali Katt',
    'Amanda Lay',
    'Amanda Lynn',
    'Amber Green',
    'Andy Friese',
    'Anita Bath',
    'Anita Lay',
    'Anna Graham',
    'Anna Prentice',
    'Anna Recksiek',
    'Anna Sasin',
    'Barry Cade',
    'Beau Archer',
    'Ben Dover',
    'Bess Eaton',
    'Biff Wellington',
    'Bill Board',
    'Bill Ding',
    'Bill Foldes',
    'Bill Loney',
    'Carrie Oakey',
    'Casey Macy',
    'Harry Pitts',
    'Dick Trickle'
  ]

  def enroll_students
    FULL_NAMES.map { |full_name| enroll_student(full_name) }
  end
  
  def enroll_student(full_name)
    student = Factory :student, :full_name => full_name
    Factory :studier, :student => student, :course => course
    student
  end
end